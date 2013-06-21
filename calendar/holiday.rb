require 'active_support/all'

class ParentsDayCalculator
  def initialize(parentsday_month)
    @parentsday_month = parentsday_month
  end

  def next_parentsday(date_to_check)
    calc_parentsday(date_to_check.year, date_to_check)
  end

  private

  def calc_parentsday(year, date_to_check)
    parentsday = second_sunday_of(year, @parentsday_month)
    return parentsday if date_to_check <= parentsday
    calc_parentsday(year + 1, date_to_check)
  end

  def second_sunday_of(year, month)
    first_day_of_month = Date.new(year, month, 1)
    first_sunday = first_day_of_month.sunday
    first_sunday + 1.week
  end
end

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
      pdc = ParentsDayCalculator.new(month)
      pdc.next_parentsday(date_to_check)
    end
  end
end

