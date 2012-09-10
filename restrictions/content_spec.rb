require 'ostruct'
require_relative 'content'

describe Content do

  subject { Content.new(:created_by => 37, :restricted => false) }

  let(:guest) { OpenStruct.new }
  let(:alice) { OpenStruct.new(:id => 13, :god => false) }
  let(:bob) { OpenStruct.new(:id => 37, :god => false) }
  let(:odin) { OpenStruct.new(:id => 1337, :god => true) }

  it { subject.editable_by?(guest).should eq false }
  it { subject.editable_by?(alice).should eq false }
  it { subject.editable_by?(bob).should eq true }
  it { subject.editable_by?(odin).should eq true }

  it { subject.visible_to?(guest).should eq true }
  it { subject.visible_to?(alice).should eq true }
  it { subject.visible_to?(bob).should eq true }
  it { subject.visible_to?(odin).should eq true }

  context "restricted content" do
    subject { Content.new(:created_by => 37, :restricted => true) }

    it { subject.visible_to?(guest).should eq false }
    it { subject.visible_to?(alice).should eq false }
    it { subject.visible_to?(bob).should eq true }
    it { subject.visible_to?(odin).should eq true }
  end

end
