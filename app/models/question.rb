class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: destroy
  has_many :votes, as: :votable, dependent: destroy
  has_many :comments, as: :commentable
end
