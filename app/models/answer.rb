# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  question_id :integer          not null
#  user_id     :integer          not null
#  text        :text             not null
#  accepted    :boolean          default(FALSE)
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Answer < ApplicationRecord
  revisionable
  commentable
  votable
  soft_deletable

  validates_presence_of :question, :user, :text

  belongs_to :question
  belongs_to :user
end
