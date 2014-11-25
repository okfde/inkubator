require 'spec_helper'

describe IdeasController, type: :controller do

  login_user

  describe "GET index" do
    it "assigns all ideas as @ideas" do
      idea = create(:idea)
      get :index
      expect(assigns(:ideas)).to eq([idea])
    end
    context "ideas complete" do
      it "does not assign them as @ideas_archive" do
        idea = create(:idea, status: 1, updated_at: 8.days.ago)
        get :index
        expect(assigns(:ideas_archive)).to_not include(idea)
      end
    end
  end

  describe "GET show" do
    it "assigns the requested idea as @idea" do
      idea = create(:idea)
      get :show, {:id => idea.to_param}
      expect(assigns(:idea)).to eq(idea)
    end
  end

  describe "GET new" do
    it "assigns a new idea as @idea" do
      get :new
      expect(assigns(:idea)).to be_a_new(Idea)
    end
  end

  describe "GET edit" do
    it "assigns the requested idea as @idea" do
      idea = create(:idea)
      get :edit, id: idea.to_param
      expect(assigns(:idea)).to eq(idea)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Idea" do
        expect {
          post :create, idea: attributes_for(:idea)
        }.to change(Idea, :count).by(1)
      end

      it "assigns a newly created idea as @idea" do
        post :create, idea: attributes_for(:idea)
        expect(assigns(:idea)).to be_a(Idea)
        expect(assigns(:idea)).to be_persisted
      end
    end
  end

  describe "DELETE destroy" do
    login_admin
    before(:each) do
      @idea = create(:idea)
    end
    it "destroys the requested idea" do
      expect {
        delete :destroy, id: @idea.to_param
      }.to change(Idea, :count).by(-1)
    end

    it "redirects to the ideas list" do
      delete :destroy, {:id => @idea.to_param}
      expect(response).to redirect_to(ideas_url)
    end
  end

  describe "POST update_votes" do
    login_user
    before :each do
      @idea = create(:idea, :voting_stage)
    end
    context "valid parameters" do
      let(:voting) { { problem: 0, goal: 0, impact: 0 } }
      context "first voter" do
        it "creates a new vote" do
          expect {
            post :update_votes, idea_id: @idea.to_param, voting: voting
          }.to change(Voting, :count).by(1)
        end
      end
      context 'last voter' do
        it "changes idea state to finance" do
          allow_any_instance_of(Idea).to receive(:all_votes_necessary?) { true }
          allow_any_instance_of(Idea).to receive(:send_mail_about_progress_to_finance) { }
          expect {
            post :update_votes, idea_id: @idea.to_param, voting: voting
          }.to change{ @idea.reload.workflow_state}.to("finance")
        end
        it "sends email to user" do
          allow_any_instance_of(Idea).to receive(:all_votes_necessary?) { true }
          expect_any_instance_of(Idea).to receive(:send_mail_about_progress_to_finance)
          post :update_votes, idea_id: @idea.to_param, voting: voting
        end
      end
    end
    context "invalid parameters" do
      it "does not create a new vote" do
        expect {
          post :update_votes, idea_id: @idea.to_param, voting: {}
        }.to_not change(Voting, :count)
      end
    end
  end
end
