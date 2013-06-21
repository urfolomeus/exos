require 'active_support/all'

# in Norway
module Calendar
  module Holiday

    def date_for_mothersday(date_to_check = Date.today)
      date_for_parentsday(2, date_to_check)
    end

    def date_for_fathersday(date_to_check = Date.today)
      date_for_parentsday(11, date_to_check)
    end

    def date_for_parentsday(month, date_to_check)
      # Day number 8 will guarantee the second Sunday of the month
      close_date = Date.new(date_to_check.year, month, 8)
      requested_years_parentsday = next_sunday_after(close_date)
      if requested_years_parentsday >= date_to_check
        requested_years_parentsday
      else
        next_sunday_after(close_date + 1.year)
      end
    end

    def next_sunday_after(date)
      date.sunday
    end

  end
end

