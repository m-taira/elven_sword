class WorkTime
  EARLY_WORK_START_HOUR = 0
  NORMAL_WORK_START_HOUR = 5
  LATE_WORK_START_HOUR = 22

  def initialize(start_datetime, end_datetime)
    @start_datetime = start_datetime
    @end_datetime = end_datetime

    @date = @start_datetime.beginning_of_day

    split_work_time
  end

  def early_work_hours
    return 0.0 unless @early_work_priod
    (@early_work_priod.end - @early_work_priod.begin) / 60 / 60
  end

  def normal_work_hours
    return 0.0 unless @normal_work_priod
    work_hours = (@normal_work_priod.end - @normal_work_priod.begin) / 60 / 60
    if work_hours >= 8
      8.0
    else
      work_hours
    end
  end

  def overtime_work_hours
    return 0.0 unless @late_work_priod
    work_hours = (@normal_work_priod.end - @normal_work_priod.begin) / 60 / 60
    if work_hours >= 8
      work_hours - 8.0
    else
      0.0
    end
  end

  def late_work_hours
    return 0.0 unless @late_work_priod
    (@late_work_priod.end - @late_work_priod.begin) / 60 / 60
  end

  private
  def split(time_range, separate)
    if time_range.cover?(separate)
      [(time_range.begin...separate), (separate...time_range.end)]
    elsif separate < time_range.begin
      [nil, time_range]
    elsif separate > time_range.end
      [time_range, nil]
    end
  end

  def split_work_time
    @early_work_priod, normal_and_late_work_time = split((@start_datetime..@end_datetime), @date + NORMAL_WORK_START_HOUR * 60 * 60)

    if normal_and_late_work_time.nil?
      @normal_work_priod = nil
      @late_work_priod = nil
    else
      @normal_work_priod, @late_work_priod = split(normal_and_late_work_time, @date + LATE_WORK_START_HOUR * 60 * 60)
    end
  end
end