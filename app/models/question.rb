class Question < ApplicationRecord
  has_many :answers
  belongs_to :user
  has_many :comments, as: :commentable, dependent: delete_question_dependent_entities
  has_many :votes, as: :votable, dependent: delete_question_dependent_entities
  has_many :revisions, as: :revisionable
  has_many :tag_associations, as: :taggable
  has_many :tags, through: :tag_associations
end
