require 'active_support/all'

class ParentsDayCalculator
  def initialize(parentsday_month)
    @parentsday_month = parentsday_month
  end

  def next_date(date_to_check)
    calc_next_date(date_to_check.year, date_to_check)
  end

  private

  def calc_next_date(year, date_to_check)
    parentsday = second_sunday_of(year)
    return parentsday if date_to_check <= parentsday
    calc_next_date(year + 1, date_to_check)
  end

  def second_sunday_of(year)
    first_day_of_month = Date.new(year, @parentsday_month, 1)
    first_sunday = first_day_of_month.sunday
    first_sunday + 1.week
  end
end

class MothersdayCalculator
  FEBRUARY = 2

  def for_year(year)
    second_sunday_of(FEBRUARY, year)
  end

  def second_sunday_of(month, year)
    first_day_of_month = Date.new(year, month, 1)
    first_sunday = first_day_of_month.sunday
    first_sunday + 1.week
  end
end

class FathersdayCalculator
  NOVEMBER = 11

  def for_year(year)
    second_sunday_of(NOVEMBER, year)
  end

  def second_sunday_of(month, year)
    first_day_of_month = Date.new(year, month, 1)
    first_sunday = first_day_of_month.sunday
    first_sunday + 1.week
  end
end

# in Norway
module Calendar
  module Holiday
    def date_for_mothersday(date_to_check = Date.today)
      mdc = MothersdayCalculator.new
      this_mothersday = mdc.for_year(date_to_check.year)
      return this_mothersday if date_to_check <= this_mothersday
      mdc.for_year(date_to_check.year + 1)
    end

    def date_for_fathersday(date_to_check = Date.today)
      fdc = FathersdayCalculator.new
      this_fathersday = fdc.for_year(date_to_check.year)
      return this_fathersday if date_to_check <= this_fathersday
      fdc.for_year(date_to_check.year + 1)
    end
  end
end

