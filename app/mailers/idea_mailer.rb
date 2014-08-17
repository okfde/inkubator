class IdeaMailer < ActionMailer::Base
  default from: "Christian.Kreutz@okfn.org"

  def new_idea(user, idea)
      @idea = idea
      @username = user.name
      mail(:to => user.email,
        :subject => "[OKF Inkubator]" + t("new_idea"),
        :template_name => 'new_idea')
  end

  def idea_made_votes(user, idea)
    @idea = idea
    @username = user.name
    mail(:to => user.email,
      :subject => "[OKF Inkubator]" + @idea.title,
      :template_name => 'idea_made_votes')
  end

  def idea_votes_board(user, idea)
    @idea = idea
    @username = user.name
    mail(:to => user.email,
      :subject => "[OKF Inkubator]" + @idea.title,
      :template_name => 'idea_votes_board')
  end

  def remember_vote(user, idea)
    @idea = idea
    @username = user.name
    mail(:to => user.email,
    :subject => "[OKF Inkubator] Erinnerung: #{t("voting")} #{idea.title}",
    :template_name => 'remember_vote')
  end

  def remember_finance_vote(user, idea)
    @idea = idea
    @username = user.name
    mail(:to => user.email,
    :subject => "[OKF Inkubator] Erinnerung: #{t("voting")} #{idea.title}",
    :template_name => 'remember_finance_vote')
  end
  def mentor_missing(user, idea)
     @idea = idea
     @username = user.name
     mail(:to => user.email,
        :subject => "[OKF Inkubator] Erinnerung: Mentor finden - #{idea.title}",
        :template_name => 'mentor_missing')
   end
end
