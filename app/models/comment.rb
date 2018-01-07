# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  commentable_type :string           not null
#  commentable_id   :integer          not null
#  user_id          :integer          not null
#  text             :text
#  deleted_at       :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Comment < ApplicationRecord
  validates_presence_of :commentable, :user

  after_save :create_revision

  def create_revision
    Revision.create(revisionable: self, metadata: { text: text })
  end

  scope :active, -> { where(deleted_at: nil) }

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :revisions, as: :revisionable
end
