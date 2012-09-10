require 'active_support/all'

# in Norway
module Calendar
  module Holiday

    def date_for_mothersday(today = Time.now.utc)
      date_for_parentsday(2, today)
    end

    def date_for_fathersday(today = Time.now.utc)
      date_for_parentsday(11, today)
    end

    def date_for_parentsday(month, today)
      # Day number 8 will guarantee the second Sunday of the month
      close_date = Time.utc(today.year, month, 8)
      possible_parentsday = next_sunday_after(close_date)
      if possible_parentsday >= today.beginning_of_day
        actual_parentsday = possible_parentsday
      else
        actual_parentsday = next_sunday_after(close_date + 1.year)
      end
      return actual_parentsday
    end

    def next_sunday_after(time)
      return time + ((7 - time.wday) % 7) * 1.day
    end

  end
end
