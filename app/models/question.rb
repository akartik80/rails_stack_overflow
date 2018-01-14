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
# Indexes
#
#  index_questions_on_deleted_at  (deleted_at)
#  index_questions_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
