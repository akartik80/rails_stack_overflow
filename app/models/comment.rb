class Comment < ApplicationRecord
  validates_presence_of :commentable, :user

  after_save :create_revision

  def create_revision
    Revision.create(revisionable: self, metadata: { text: text })
  end

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :revisions, as: :revisionable
end
