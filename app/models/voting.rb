class Voting < ActiveRecord::Base
  attr_accessible :user_id, :idea_id, :problem, :goal, :impact, :finance

  belongs_to :user
  belongs_to :idea

  def self.for_idea(idea, user)
    if existing_idea = where(user_id: user.id, idea_id: idea.id).first
      existing_idea
    else
      Voting.new(user_id: user.id, idea_id: idea.id)
    end
  end

  [:problem, :goal, :impact].each do |paragraph_name|
    define_method("#{paragraph_name}=") do |value|
      super(value.blank? ? nil : value)
    end
  end
end