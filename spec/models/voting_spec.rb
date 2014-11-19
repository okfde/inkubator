require 'spec_helper'

describe Voting do

  subject { create(:voting) }

  it { should belong_to(:user) }
  it { should belong_to(:idea) }

  it { should validate_inclusion_of(:problem).in_array([1, -1, 0]) }
  it { should validate_inclusion_of(:goal).in_array([1, -1, 0]) }
  it { should validate_inclusion_of(:impact).in_array([1, -1, 0]) }

  describe "#problems" do
    let(:voting) { create(:voting, problem: 1) }
    it do
      result = Voting.problems
      expect(result).to include(voting)
    end
  end

  describe "#goals" do
    let(:voting) { create(:voting, goal: 1) }
    it do
      result = Voting.goals
      expect(result).to include(voting)
    end
  end

  describe "#impacts" do
    let(:voting) { create(:voting, impact: 1) }
    it do
      result = Voting.impacts
      expect(result).to include(voting)
    end
  end
end
