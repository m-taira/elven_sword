class CreateDailyReports < ActiveRecord::Migration
  def change
    create_table :daily_reports do |t|
      t.integer :user_id
      t.date :date
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.string :work_status

      t.timestamps
    end
  end
end
