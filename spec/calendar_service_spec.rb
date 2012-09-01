require_relative '../calendar_service.rb'

describe CalendarService do

  subject { stub.extend(CalendarService) }

  describe "mothersday" do
    it { subject.date_for_mothersday(Time.utc(1986, 2, 1)).should eq(Time.utc(1986, 2, 9)) }
    it { subject.date_for_mothersday(Time.utc(2012, 2, 1)).should eq(Time.utc(2012, 2, 12)) }
    it { subject.date_for_mothersday(Time.utc(2012, 2, 12)).should eq(Time.utc(2012, 2, 12)) }
    it { subject.date_for_mothersday(Time.utc(2012, 2, 13)).should eq(Time.utc(2013, 2, 10)) }
  end

  describe "fathersday" do
    it { subject.date_for_fathersday(Time.utc(1986, 11, 1)).should eq(Time.utc(1986, 11, 9)) }
    it { subject.date_for_fathersday(Time.utc(2012, 11, 1)).should eq(Time.utc(2012, 11, 11)) }
    it { subject.date_for_fathersday(Time.utc(2012, 11, 11)).should eq(Time.utc(2012, 11, 11)) }
    it { subject.date_for_fathersday(Time.utc(2012, 11, 12)).should eq(Time.utc(2013, 11, 10)) }
  end
end
