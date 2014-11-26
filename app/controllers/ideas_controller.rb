class IdeasController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  has_scope :finished, only: :index
  has_scope(:by_type, default: "active", only: :index) do |controller, scope, value|
    scope.send(value)
  end
  has_scope :order, default: "updated_at", only: :index
  has_scope(:by_phase, default: "all", only: :index) do |controller, scope, value|
    value == "all" ? scope : scope.send("#{value}_step")
  end

  def index
    @ideas = apply_scopes(Idea).all

    respond_to do |format|
      format.html
      format.json { render json: @ideas }
    end
  end

  def edit_votes
    @idea = Idea.find(params[:idea_id])
    @voting = Voting.for_idea(@idea, current_user)
  end

  def edit_votes_finance
    @idea = Idea.find(params[:idea_id])
    @voting = Voting.for_idea(@idea, current_user)
  end

  def show
    @idea = Idea.find(params[:id])
    @comments = @idea.comments.order(:created_at)

    respond_to do |format|
      format.html
      format.json { render json: @idea }
    end
  end

  def new
    @idea = Idea.new

    respond_to do |format|
      format.html
      format.json { render json: @idea }
    end
  end

  def edit
    @idea = Idea.find(params[:id])
  end

  def update_votes_finance
    @idea = Idea.find(params[:idea_id])

    @voting = Voting.for_idea(@idea, current_user)
    @finance_votes = @idea.votings.where(:finance => true).count

    if @voting.update_attributes(params[:voting])
      if @finance_votes >= 7
        @idea.update_column(:status, 1)

        #IdeaMailer.idea_votes_board(current_user, @idea).deliver
        #IdeaMailer.idea_made_votes(@idea.user, @idea).deliver
      end
      redirect_to idea_path(@idea)
    else
      # failure
    end
  end

  def update_votes
    @idea = Idea.find(params[:idea_id])

    @voting = Voting.for_idea(@idea, current_user)

    if @voting.update_attributes(params[:voting])
      if @idea.workflow_state == 'voting'
        @problem_votes = @idea.votings.where(:problem => true).count
        @goal_votes = @idea.votings.where(:goal => true).count
        @impact_votes = @idea.votings.where(:impact => true).count
        if @problem_votes >= 7 && @goal_votes >= 7 &&  @impact_votes >= 7
          @idea.update_column(:workflow_state, "finance")
          users = User.board_members
          users.each do |user|
            IdeaMailer.idea_votes_board(user, @idea).deliver
        end
          IdeaMailer.idea_made_votes(@idea.user, @idea).deliver
        end
      end
      redirect_to idea_path(@idea)
    else
      # failure
    end
  end

  def edit_finance
    @idea = Idea.find(params[:idea_id])
  end

  def update_finance
    @idea = Idea.find(params[:idea_id])
    @idea.update_column(:workflow_state, "finance_voting")

    respond_to do |format|
      if @idea.update_attributes(params[:idea])
        format.html { redirect_to @idea, notice: 'Idee wurde gespeichert.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_mentor
    @users = User.all
    @idea = Idea.find(params[:idea_id])
  end

  def update_mentor
    @idea = Idea.find(params[:idea_id])

    respond_to do |format|
      had_mentors = @idea.mentors.exists?
      if @idea.update_attributes(params[:idea])
        if !had_mentors && @idea.mentors.exists?
          @idea.update_column(:workflow_state, "voting")
          users = User.board_members
          users.each do |user|
            IdeaMailer.new_idea(user, @idea).deliver
          end
        end
        format.html { redirect_to @idea, notice: 'Idee wurde gespeichert.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @idea = current_user.ideas.build(params[:idea])
    @idea.workflow_state = "mentor"

    respond_to do |format|
      if @idea.save
        format.html { redirect_to @idea, notice: 'Idea was successfully created.' }
        format.json { render json: @idea, status: :created, location: @idea }
      else
        format.html { render action: "new" }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @idea = Idea.find(params[:id])

    respond_to do |format|
      if @idea.update_attributes(params[:idea])
        format.html { redirect_to @idea, notice: 'Idee wurde gespeichert.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy

    respond_to do |format|
      format.html { redirect_to ideas_url }
      format.json { head :no_content }
    end
  end
end
