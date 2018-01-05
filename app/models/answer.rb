class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :votes, as: :votable, dependent: delete_answer_dependent_entities
  has_many :comments, as: :commentable, dependent: delete_answer_dependent_entities
  has_many :revisions, as: :revisionable

  def delete_answer_dependent_entities
  end
end
