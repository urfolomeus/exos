require_relative '../mothersday.rb'

describe "Mothersday" do

  subject { stub.extend(CalendarService) }

  it { subject.date_for_mothersday(Time.utc(1986, 2, 1)).should eq(Time.utc(1986, 2, 9)) }
  it { subject.date_for_mothersday(Time.utc(2012, 2, 1)).should eq(Time.utc(2012, 2, 12)) }
  it { subject.date_for_mothersday(Time.utc(2012, 2, 12)).should eq(Time.utc(2012, 2, 12)) }
  it { subject.date_for_mothersday(Time.utc(2012, 2, 13)).should eq(Time.utc(2013, 2, 10)) }
end
