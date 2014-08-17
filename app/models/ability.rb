class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    if user.superadmin?
      can :manage, :all
    else
      if user.board?
        can :read, :all
        can :edit_votes, Idea
        can :update_votes, Idea
        can :edit_votes_finance, Idea
        can :update_votes_finance, Idea
      end

      if user.observer?
        can :read, :all
      end

      can :read, Idea do |idea|
        idea.try(:user) == user
      end
      can :read, Comment

      can :create, Comment
      can :create, Idea

      can [:update, :update_mentor, :edit_mentor, :edit_finance, :update_finance], Idea do |idea|
        idea.try(:user) == user
      end
    end
  end
end
