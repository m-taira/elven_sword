json.array!(@daily_reports) do |daily_report|
  json.extract! daily_report, :id, :user_id, :date, :start_datetime, :end_datetime, :work_status
  json.url daily_report_url(daily_report, format: :json)
end
