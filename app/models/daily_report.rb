class DailyReport < ActiveRecord::Base
  include Enumerize
  enumerize :work_status, in: [:attendance, :paid_vacation], default: :attendance

  def start_datetime=(time)
    super("#{date} #{time}")
  end

  def start_datetime
    super.try(:strftime, "%H:%M")
  end

  def end_datetime=(time)
    super("#{date} #{time}")
  end

  def end_datetime
    super.try(:strftime, "%H:%M")
  end


end
