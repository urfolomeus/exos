require_relative 'holiday'

describe Calendar::Holiday do

  subject { stub.extend(Calendar::Holiday) }

  let(:now) { Date.today }

  describe "mothersday" do
    it { subject.date_for_mothersday(Date.new(1986, 2, 1)).should eq(Date.new(1986, 2, 9)) }
    it { subject.date_for_mothersday(Date.new(2012, 2, 1)).should eq(Date.new(2012, 2, 12)) }
    it { subject.date_for_mothersday(Date.new(2012, 2, 12)).should eq(Date.new(2012, 2, 12)) }
    it { subject.date_for_mothersday(Date.new(2012, 2, 13)).should eq(Date.new(2013, 2, 10)) }

    it "defaults to today" do
      expected = subject.date_for_mothersday(now)
      subject.date_for_mothersday.should eq(expected)
    end
  end

  describe "fathersday" do
    it { subject.date_for_fathersday(Date.new(1986, 11, 1)).should eq(Date.new(1986, 11, 9)) }
    it { subject.date_for_fathersday(Date.new(2012, 11, 1)).should eq(Date.new(2012, 11, 11)) }
    it { subject.date_for_fathersday(Date.new(2012, 11, 11)).should eq(Date.new(2012, 11, 11)) }
    it { subject.date_for_fathersday(Date.new(2012, 11, 12)).should eq(Date.new(2013, 11, 10)) }

    it "defaults to today" do
      expected = subject.date_for_fathersday(now)
      subject.date_for_fathersday.should eq(expected)
    end
  end
end
