require 'active_support/all'

# in Norway
module Calendar
  module Holiday
    FEBRUARY = 2
    NOVEMBER = 11

    def mothersday_for_year(year)
      second_sunday_of(FEBRUARY, year)
    end

    def fathersday_for_year(year)
      second_sunday_of(NOVEMBER, year)
    end

    def second_sunday_of(month, year)
      first_day_of_month = Date.new(year, month, 1)
      first_sunday = first_day_of_month.sunday
      first_sunday + 1.week
    end

    def date_for_mothersday(date_to_check = Date.today)
      this_mothersday = mothersday_for_year(date_to_check.year)
      return this_mothersday if date_to_check <= this_mothersday
      mothersday_for_year(date_to_check.year + 1)
    end

    def date_for_fathersday(date_to_check = Date.today)
      this_fathersday = fathersday_for_year(date_to_check.year)
      return this_fathersday if date_to_check <= this_fathersday
      fathersday_for_year(date_to_check.year + 1)
    end
  end
end

