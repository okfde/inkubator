class CommentMailer < ActionMailer::Base
  default from: "info@okfn.de"

  def new_comment(user, comment)
     @idea = comment.commentable
     @username = user.name
     @comment = comment
     mail(:to => user.email,
        :subject => "[OKF Inkubator] Neuer Kommentar - #{@idea.title}",
        :template_name => 'new_comment')
   end
end
