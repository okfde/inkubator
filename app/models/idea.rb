class Idea < ActiveRecord::Base

  PHASE = ['ideenskizze', 'mentor', 'voting', 'finance', 'finance_voting']

  attr_accessible :description, :status, :problem, :goal, :impact, :title, :workflow_state, :mentor_ids, :finance
  belongs_to :user

  validates_presence_of :title, :description, :problem, :user_id, :goal, :impact, :message => :is_required
  has_and_belongs_to_many :mentors, class_name: 'User', join_table: :mentors

  has_many :comments, as: :commentable, dependent: :destroy

  has_many :votings

  PHASE.each do |phase_name|
    scope "#{phase_name}_step", ->{ where(workflow_state: phase_name) }
  end

  scope :entered_step_before, ->(timestamp) { where('ideas.updated_at < ?', timestamp)}
  scope :active, ->(timestamp) { where('ideas.updated_at > ?', timestamp)}


  validates :problem, :length => { :maximum => 300, :message => :maximum_content, :minimum => 80, :message => :minimum_content}
  validates :goal, :length => { :maximum => 300, :message => :maximum_content, :minimum => 80, :message => :minimum_content}
  validates :impact, :length => { :maximum => 300, :message => :maximum_content, :minimum => 80, :message => :minimum_content}
  #validates :finance, :length => { :maximum => 300, :message => :maximum_content, :minimum => 80, :message => :minimum_content}


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
end
