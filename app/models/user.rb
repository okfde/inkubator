class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :username
  has_many :comments, :dependent => :destroy
  has_many :ideas
  has_and_belongs_to_many :mentor_ideas, class_name: 'Idea', join_table: :mentors
  has_many :votings

  scope :board_members, ->{ where(role: :board) }
  scope :not_voted_for_idea, ->(idea) do
    where(<<SQL)
    NOT EXISTS
    (SELECT * FROM votings WHERE votings.user_id = users.id AND votings.idea_id = #{idea.id})
SQL
  end
  scope :not_voted_finance_for_idea, ->(idea) do
    where(<<SQL)
    EXISTS
    (SELECT * FROM votings WHERE votings.user_id = users.id AND votings.idea_id = #{idea.id}
      AND votings.finance IS NULL)
SQL
  end

  # Avoids to insert current user password to change settings
   def update_with_password(params={})
     if params[:password].blank?
       params.delete(:password)
       params.delete(:password_confirmation) if params[:password_confirmation].blank?
     end
     update_attributes(params)
   end

  def superadmin?
    role == 'superadmin'
  end

  def board?
    role == 'board'
  end

  def observer?
    role == 'observer'
  end

  def name
    username || email.split("@")[0]
  end
end
