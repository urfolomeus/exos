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

class MothersdayCalculator < ParentsDayCalculator
  FEBRUARY = 2

  def initialize
    super(FEBRUARY)
  end
end

class FathersdayCalculator < ParentsDayCalculator
  NOVEMBER = 11

  def initialize
    super(NOVEMBER)
  end
end

# in Norway
module Calendar
  module Holiday
    def date_for_mothersday(date_to_check = Date.today)
      mdc = MothersdayCalculator.new
      mdc.next_date(date_to_check)
    end

    def date_for_fathersday(date_to_check = Date.today)
      fdc = FathersdayCalculator.new
      fdc.next_date(date_to_check)
    end
  end
end

