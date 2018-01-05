class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :revisions, as: :revisionable

  validates_presence_of :commentable_type, :commentable_id, user_id
end
