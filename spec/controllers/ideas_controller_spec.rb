require 'spec_helper'
require 'pry'

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

end
