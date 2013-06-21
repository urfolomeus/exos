require 'active_support/all'

module RecurringCalcs
  def second_sunday_of(month, year)
    first_day_of_month = Date.new(year, month, 1)
    first_sunday = first_day_of_month.sunday
    first_sunday + 1.week
  end
end

class MothersDay
  include RecurringCalcs

  FEBRUARY = 2

  def falls_on(year)
    second_sunday_of(FEBRUARY, year)
  end
end

class FathersDay
  include RecurringCalcs

  NOVEMBER = 11

  def falls_on(year)
    second_sunday_of(NOVEMBER, year)
  end
end

# in Norway
module Calendar
  module Holiday
    def date_for_mothersday(date_to_check = Date.today)
      next_occurence(MothersDay.new, date_to_check)
    end

    def date_for_fathersday(date_to_check = Date.today)
      next_occurence(FathersDay.new, date_to_check)
    end

    def next_occurence(holiday, date_to_check)
      if date_to_check <= holiday.falls_on(date_to_check.year)
        holiday.falls_on(date_to_check.year)
      else
        holiday.falls_on(date_to_check.year + 1)
      end
    end
  end
end

