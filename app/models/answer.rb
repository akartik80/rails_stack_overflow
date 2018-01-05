class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :votes, as: :votable
  has_many :comments, as: :commentable
  has_many :revisions, as: :revisionable

  validates_presence_of :question_id, :user_id, :text
end
