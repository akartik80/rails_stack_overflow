class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :votes, as: :votable
  has_many :comments, as: :commentable
  has_many :revisions, as: :revisionable
end
