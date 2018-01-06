# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  votable_type :string           not null
#  votable_id   :integer          not null
#  user_id      :integer          not null
#  vote_type    :integer          not null
#  deleted_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Vote < ApplicationRecord
  validates_presence_of :votable, :user, :vote_type
  has_many :revisions, as: :revisionable

  after_save :create_revision

  def create_revision
    Revision.create(revisionable: self, metadata: { vote_type: vote_type })
  end

  belongs_to :votable, polymorphic: true
  belongs_to :user

  scope :active, -> { where(deleted_at: nil) }
end
