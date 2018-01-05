class Comment < ApplicationRecord
  validates_presence_of :commentable, :user

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :revisions, as: :revisionable
end
