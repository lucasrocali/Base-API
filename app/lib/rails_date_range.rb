module RailsDateRange
  require 'active_support/all'
  class RailsDateRange < Range
    attr_accessor :time_range

    def set_day_range(time_range)
      self.time_range = time_range
      return self
    end

    def belong_to_time_range(c_time)
      if c_time.wday >= self.time_range.from_week_day && c_time.wday <= self.time_range.to_week_day && c_time.hour >= self.time_range.from_day_time.hour && c_time.hour <= self.time_range.to_day_time.hour
        return true
      end
      return false
    end

    def every(step, &block)
      c_time = self.begin.to_datetime
      finish_time = self.end.to_datetime
      compare =  :<=

      arr = []
      while c_time.send( compare, finish_time) do 
        if belong_to_time_range(c_time)
          arr << c_time
      end
        c_time = c_time.advance(step)
      end

      return arr
    end
  end

  # Convenience method
  def RailsDateRange(range,time_range)
    RailsDateRange.new(range.begin, range.end, range.exclude_end?).set_day_range(time_range)
  end
end