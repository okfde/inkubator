task :voting_reminder => :environment do
  Idea.voting_step.entered_step_before(3.days.ago).each do |idea|
    User.board_members.not_voted_for_idea(idea).each do |user|
      if idea.status.blank?
        IdeaMailer.remember_vote(user, idea).deliver
      end
    end
  end

  Idea.finance_voting_step.entered_step_before(3.days.ago).each do |idea|
    # Users who did not vote
    User.board_members.not_voted_for_idea(idea).each do |user|
      if idea.status.blank?
        IdeaMailer.remember_vote(user, idea).deliver
      end
    end

    # Users who voted but not yet for the finance step
    User.board_members.not_voted_finance_for_idea(idea).each do |user|
      if idea.status.blank?
        IdeaMailer.remember_finance_vote(user, idea).deliver
      end
    end
  end
end

task :mentor_reminder => :environment do
  Idea.mentor_step.entered_step_before(24.hours.ago).each do |idea|
    IdeaMailer.mentor_missing(idea.user, idea).deliver
  end
end