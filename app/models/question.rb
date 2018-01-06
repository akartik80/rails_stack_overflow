class Question < ApplicationRecord
  validates_presence_of :user, :text
  after_save :create_revision

  def create_revision
    Revision.create(revisionable: self, metadata: { text: text })
  end

  belongs_to :user

  has_many :answers
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
  has_many :revisions, as: :revisionable

  has_and_belongs_to_many :tags

  scope :active, -> { where(deleted_at: nil) }
end
