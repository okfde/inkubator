class Comment < ActiveRecord::Base
  attr_accessible :content
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates_presence_of :user
end
