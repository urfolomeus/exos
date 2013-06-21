require_relative 'holiday'

describe Calendar::Holiday do
  let(:holiday_test) { stub.extend(Calendar::Holiday) }
  let(:now)          { Date.today }

  describe "mothersday" do
    let(:this_mothersday) { Date.parse('Sun 12th February, 2012') }
    let(:next_mothersday) { Date.parse('Sun 10th February, 2013') }

    subject { holiday_test.next_occurence(MothersDay.new, date_to_check) }

    context "when date_to_check is before the holiday of that year" do
      let(:date_to_check) { this_mothersday - 1 }

      it "provides the holiday for that year" do
        subject.should eq(this_mothersday)
      end
    end

    context "when date_to_check is on the holiday of that year" do
      let(:date_to_check) { this_mothersday }

      it "provides the holiday for that year" do
        subject.should eq(this_mothersday)
      end
    end

    context "when date_to_check is after the holiday of that year" do
      let(:date_to_check) { this_mothersday + 1 }

      it "provides the holiday for the following year" do
        subject.should eq(next_mothersday)
      end
    end
  end

  it "defaults to today" do
    expected = holiday_test.next_occurence(MothersDay.new, now)
    holiday_test.next_occurence(MothersDay.new).should eq(expected)
  end

  describe "fathersday" do
    subject { holiday_test }

    it { subject.next_occurence(FathersDay.new, Date.new(1986, 11, 1)).should eq(Date.new(1986, 11, 9)) }
    it { subject.next_occurence(FathersDay.new, Date.new(2012, 11, 1)).should eq(Date.new(2012, 11, 11)) }
    it { subject.next_occurence(FathersDay.new, Date.new(2012, 11, 11)).should eq(Date.new(2012, 11, 11)) }
    it { subject.next_occurence(FathersDay.new, Date.new(2012, 11, 12)).should eq(Date.new(2013, 11, 10)) }

    it "defaults to today" do
      expected = subject.next_occurence(FathersDay.new, now)
      subject.next_occurence(FathersDay.new).should eq(expected)
    end
  end

  describe "christmas day" do
    subject { holiday_test }

    it { subject.next_occurence(ChristmasDay.new, Date.new(1986, 12, 1)).should eq(Date.new(1986, 12, 25)) }
    it { subject.next_occurence(ChristmasDay.new, Date.new(2012, 12, 24)).should eq(Date.new(2012, 12, 25)) }
    it { subject.next_occurence(ChristmasDay.new, Date.new(2012, 12, 25)).should eq(Date.new(2012, 12, 25)) }
    it { subject.next_occurence(ChristmasDay.new, Date.new(2012, 12, 26)).should eq(Date.new(2013, 12, 25)) }

    it "defaults to today" do
      expected = subject.next_occurence(ChristmasDay.new, now)
      subject.next_occurence(ChristmasDay.new).should eq(expected)
    end
  end
end
