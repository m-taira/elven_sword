class DailyReport < ActiveRecord::Base
  extend Forwardable
  include Enumerize

  enumerize :work_status, in: [:attendance, :paid_vacation], default: :attendance

  after_initialize :calculate_work_time, unless: :new_record?

  def_delegators :@work_time, :early_work_hours, :normal_work_hours, :overtime_work_hours, :late_work_hours

  validates :start_datetime, presence: {if: ->(r){ r.work_status.attendance? }}
  validates :end_datetime,   presence: {if: ->(r){ r.work_status.attendance? }}
  validates :work_status,    presence: true

  def start_datetime=(time)
    super("#{date} #{time}") if time.present?
  end

  # def start_datetime
  #   super.try(:strftime, "%H:%M")
  # end

  def end_datetime=(time)
    super("#{date} #{time}") if time.present?
  end

  # def end_datetime
  #   super.try(:strftime, "%H:%M")
  # end

  private
  def calculate_work_time
    @work_time = WorkTime.new(start_datetime, end_datetime) if start_datetime.present? && end_datetime.present?
  end
end
