require 'spec_helper'

describe Voting do

  it { should belong_to(:user) }
  it { should belong_to(:idea) }

  it { should validate_inclusion_of(:problem).in_array([1, -1, 0]) }
  it { should validate_inclusion_of(:goal).in_array([1, -1, 0]) }
  it { should validate_inclusion_of(:impact).in_array([1, -1, 0]) }
end
