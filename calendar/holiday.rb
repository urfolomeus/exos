require 'active_support/all'

# in Norway
module Calendar
  module Holiday

    def date_for_mothersday(today = Date.today)
      date_for_parentsday(2, today)
    end

    def date_for_fathersday(today = Date.today)
      date_for_parentsday(11, today)
    end

    def date_for_parentsday(month, today)
      # Day number 8 will guarantee the second Sunday of the month
      close_date = Date.new(today.year, month, 8)
      possible_parentsday = next_sunday_after(close_date)
      if possible_parentsday >= today
        actual_parentsday = possible_parentsday
      else
        actual_parentsday = next_sunday_after(close_date + 1.year)
      end
      return actual_parentsday
    end

    def next_sunday_after(date)
      date.sunday
    end

  end
end
