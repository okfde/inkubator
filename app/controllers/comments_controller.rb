class CommentsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(params[:comment])
    @comment.user_id = current_user.id
    if @comment.save
      @commentable.comments.each do |comment|
        CommentMailer.new_comment(comment.user, @comment).deliver unless @comment.user == comment.user
      end
      CommentMailer.new_comment(@commentable.user, @comment).deliver unless @commentable.user == @comment.user
      redirect_to @commentable, :notice => t('activerecord.successful.messages.created', :model => @comment.class.model_name.human)
    else
      redirect_to @commentable, :alert => @comment.errors.full_messages.join("<br>").html_safe
    end
  end

  def update
    @commentable = find_commentable
    @comment.content = params[:comment][:content]

    if @comment.save
      redirect_to @commentable, :notice => t('activerecord.successful.messages.updated', :model => @comment.class.model_name.human)
    else
      redirect_to @commentable, :alert => @comment.errors.full_messages.join("<br>").html_safe
    end

  end

  def destroy
    @commentable = find_commentable
    @comment.destroy

    respond_to do |format|
      format.html do
        redirect_to @commentable, :alert => t('activerecord.successful.messages.destroyed', :model => @comment.class.model_name.human)
      end
      format.json { head :no_content }
    end
  end

  private

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
  end
end
