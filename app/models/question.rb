class Question < ApplicationRecord
  has_many :answers
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
  has_many :revisions, as: :revisionable
  has_many :tag_associations, as: :taggable
  has_many :tags, through: :tag_associations

  private
end
