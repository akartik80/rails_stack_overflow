class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: delete_questions_dependent_entities
  has_many :votes, as: :votable, dependent: delete_questions_dependent_entities
  has_many :comments, as: :commentable, dependent: delete_questions_dependent_entities
  has_many :revisions, as: :revisionable, dependent: delete_questions_dependent_entities

  def delete_questions_dependent_entities
  end
end
