require_relative 'e_card'

describe Gossip::ECard do
  let(:creator) { stub }
  subject { Gossip::ECard.new(:id => 1337, :created_by => creator, :recipient => 'Bob Smith') }

  its(:id) { should eq(1337) }
  its(:created_by) { should eq(creator) }
  its(:recipient) { should eq('Bob Smith') }

end
