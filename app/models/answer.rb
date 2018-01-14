class Answer < ApplicationRecord
  revisionable
  commentable
  votable
  soft_deletable

  validates_presence_of :question, :user, :text

  belongs_to :question
  belongs_to :user
end

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
# Indexes
#
#  index_answers_on_deleted_at   (deleted_at)
#  index_answers_on_question_id  (question_id)
#  index_answers_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#  fk_rails_...  (user_id => users.id)
#
