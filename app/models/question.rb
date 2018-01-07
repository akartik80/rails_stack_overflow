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
  validates_presence_of :user, :text
  after_save :create_revision

  def create_revision
    Revision.create(revisionable: self, metadata: { text: text })
  end

  scope :active, -> { where(deleted_at: nil) }

  belongs_to :user

  has_many :answers, -> { where(deleted_at: nil) }
  has_many :comments, -> { where(deleted_at: nil) }, as: :commentable
  has_many :votes, as: :votable
  has_many :revisions, as: :revisionable

  has_and_belongs_to_many :tags
end
