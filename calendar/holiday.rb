require 'active_support/all'

# in Norway
module Calendar
  module Holiday

    FEBRUARY = 2
    NOVEMBER = 11

    def date_for_mothersday(date_to_check = Date.today)
      date_for_parentsday(FEBRUARY, date_to_check)
    end

    def date_for_fathersday(date_to_check = Date.today)
      date_for_parentsday(NOVEMBER, date_to_check)
    end

    private

    def date_for_parentsday(month, date_to_check)
      requested_years_parentsday = second_sunday_of(date_to_check.year, month)
      if requested_years_parentsday >= date_to_check
        requested_years_parentsday
      else
        second_sunday_of(date_to_check.year + 1, month)
      end
    end

    def second_sunday_of(year, month)
      first_day_of_month = Date.new(year, month, 1)
      first_sunday = first_day_of_month.sunday
      first_sunday + 1.week
    end
  end
end

