require 'spec_helper'

feature "Voting" do
  before :each do
    user = create(:user, role: 'board')
    login_as(user, scope: :user)
  end
  scenario "voting for an idea" do
    idea = create(:idea, workflow_state: 'voting')
    visit idea_votes_path(idea_id: idea)
    expect( find(:css, 'select#voting_problem').value ).to eq("")
  end
end
