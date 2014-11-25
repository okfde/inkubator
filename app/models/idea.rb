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
  scope :active, ->(timestamp = 7.days.ago) { where('ideas.updated_at > ?', timestamp)}
  scope :inactive, -> (timestamp = 7.days.ago) { not_finished.entered_step_before(timestamp) }
  scope :finished, -> { where(status: 1) }
  scope :not_finished, -> { where(status: 0) }

  scope :order, -> (order) { order(order) }

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
