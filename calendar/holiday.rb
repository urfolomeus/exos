require 'active_support/all'

# in Norway
module Calendar
  module Holiday
    FEBRUARY = 2
    NOVEMBER = 11

    def date_for_mothersday(date_to_check = Date.today)
      if date_to_check <= mothersday_for(date_to_check.year)
        mothersday_for(date_to_check.year)
      else
        mothersday_for(date_to_check.year + 1)
      end
    end

    def date_for_fathersday(date_to_check = Date.today)
      if date_to_check <= fathersday_for(date_to_check.year)
        fathersday_for(date_to_check.year)
      else
        fathersday_for(date_to_check.year + 1)
      end
    end

    private

    def mothersday_for(year)
      second_sunday_of(FEBRUARY, year)
    end

    def fathersday_for(year)
      second_sunday_of(NOVEMBER, year)
    end

    def second_sunday_of(month, year)
      first_day_of_month = Date.new(year, month, 1)
      first_sunday = first_day_of_month.sunday
      first_sunday + 1.week
    end
  end
end

