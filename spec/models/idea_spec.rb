require 'spec_helper'

describe Idea do
  subject { create(:idea) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:problem) }
  it { should validate_presence_of(:goal) }
  it { should validate_presence_of(:impact) }
  it { should validate_presence_of(:user) }
  it { should ensure_length_of(:problem).is_at_least(80) }
  it { should ensure_length_of(:problem).is_at_most(300) }
  it { should ensure_length_of(:goal).is_at_least(80) }
  it { should ensure_length_of(:goal).is_at_most(300) }
  it { should ensure_length_of(:impact).is_at_least(80) }
  it { should ensure_length_of(:impact).is_at_most(412) }

  it { should belong_to(:user) }

  it { should have_and_belong_to_many(:mentors).class_name('User') }

  it { should have_many(:comments) }
  it { should have_many(:votings) }


  it "factory should be valid" do
    expect(subject).to be_valid
  end

  it { expect(subject.current_phase).to be(subject.workflow_state) }

  context 'idea not finished' do
    describe '#finished?' do
      it { expect(subject.finished?).to eq(false) }
    end
  end

  context 'idea finished' do
    subject { create(:idea, status: 1) }
    describe '#finished?' do
      it { expect(subject.finished?).to eq(true) }
    end
  end
  describe '#forward_workflow_to_finance' do
    context 'all necessary votes are given' do
      it 'changed workflow to finance' do
        allow(subject).to receive(:all_votes_necessary?) { true }
        expect{ subject.forward_workflow_to_finance }.to change{ subject.workflow_state }.to("finance")
      end
    end
    context 'not all necessary votes are given' do
      it 'does not change workflow to finance' do
        allow(subject).to receive(:all_votes_necessary?) { false }
        expect{ subject.forward_workflow_to_finance }.to_not change{ subject.workflow_state }
      end
    end
  end
end
