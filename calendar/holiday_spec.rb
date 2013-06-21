require_relative 'holiday'

describe Calendar::Holiday do

  subject { stub.extend(Calendar::Holiday) }

  let(:now) { Date.today }

  describe "mothersday" do
    it { subject.next_occurence(MothersDay.new, Date.new(1986, 2, 1)).should eq(Date.new(1986, 2, 9)) }
    it { subject.next_occurence(MothersDay.new, Date.new(2012, 2, 1)).should eq(Date.new(2012, 2, 12)) }
    it { subject.next_occurence(MothersDay.new, Date.new(2012, 2, 12)).should eq(Date.new(2012, 2, 12)) }
    it { subject.next_occurence(MothersDay.new, Date.new(2012, 2, 13)).should eq(Date.new(2013, 2, 10)) }

    it "defaults to today" do
      expected = subject.next_occurence(MothersDay.new, now)
      subject.next_occurence(MothersDay.new).should eq(expected)
    end
  end

  describe "fathersday" do
    it { subject.next_occurence(FathersDay.new, Date.new(1986, 11, 1)).should eq(Date.new(1986, 11, 9)) }
    it { subject.next_occurence(FathersDay.new, Date.new(2012, 11, 1)).should eq(Date.new(2012, 11, 11)) }
    it { subject.next_occurence(FathersDay.new, Date.new(2012, 11, 11)).should eq(Date.new(2012, 11, 11)) }
    it { subject.next_occurence(FathersDay.new, Date.new(2012, 11, 12)).should eq(Date.new(2013, 11, 10)) }

    it "defaults to today" do
      expected = subject.next_occurence(FathersDay.new, now)
      subject.next_occurence(FathersDay.new).should eq(expected)
    end
  end
end
