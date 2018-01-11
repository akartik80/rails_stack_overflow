# == Schema Information
#
# Table name: questions
#
#  id                    :integer          not null, primary key
#  user_id               :integer          not null
#  text                  :text             not null
#  duplicate_question_id :integer
#  wiki                  :boolean          default(FALSE)
#  deleted_at            :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Question < ApplicationRecord
  revisionable
  commentable
  votable
  soft_deletable

  validates_presence_of :user, :text

  belongs_to :user
  has_many :answers
  has_and_belongs_to_many :tags
end
