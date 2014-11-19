class Idea < ActiveRecord::Base

  PHASE = ['ideenskizze', 'mentor', 'voting', 'finance', 'finance_voting']

  attr_accessible :description, :status, :problem, :goal, :impact, :title, :workflow_state, :mentor_ids, :finance

  validates_presence_of :title, :description, :problem, :goal, :impact, :user

  validates :problem, length: { maximum: 300, minimum: 80 }
  validates :goal, length: { maximum: 300, minimum: 80 }
  validates :impact, length: { maximum: 412, minimum: 80 }

  has_and_belongs_to_many :mentors, class_name: 'User', join_table: :mentors
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votings

  PHASE.each do |phase_name|
    scope "#{phase_name}_step", ->{ where(workflow_state: phase_name) }
  end

  scope :entered_step_before, ->(timestamp) { where('ideas.updated_at < ?', timestamp)}
  scope :active, ->(timestamp) { where('ideas.updated_at > ?', timestamp)}

  def phase_index
    if workflow_state
      PHASE.index(workflow_state) + 1
    else
      0
    end
  end

  def progress
    if finished?
      "100%"
    else
      "#{(phase_index - 1) * 100/ PHASE.size}%"
    end
  end

  def next_phase
    PHASE[phase_index]
  end

  def current_phase
    workflow_state
  end

  def finished?
    status == 1
  end

  def forward_workflow_to_finance
    if all_votes_necessary?
      self.update_column(:workflow_state, "finance")
      send_mail_about_progress_to_finance
    end
  end

  def send_mail_about_progress_to_finance
    send_mail_to_board
    send_mail_to_user
  end

  def send_mail_to_board
    User.board_members.each do |user|
      IdeaMailer.idea_votes_board(user, self).deliver
    end
  end

  def send_mail_to_user
    IdeaMailer.idea_made_votes(user, self).deliver
  end

  def all_votes_necessary?
    problem_votes_enough? && goal_votes_enough? && impact_votes_enough?
  end

  def problem_votes_enough?
    votings.problems.count >= 7
  end

  def goal_votes_enough?
    votings.goals.count >= 7
  end

  def impact_votes_enough?
    votings.impacts.count >= 7
  end
end
