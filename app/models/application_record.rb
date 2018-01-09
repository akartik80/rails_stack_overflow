class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.revisionable
    has_many :revisions, as: :revisionable
    after_save :create_revision
  end

  def self.commentable
    has_many :comments, as: :commentable
  end

  def self.votable
    has_many :votes, as: :votable
  end

  def self.soft_deletable
    default_scope -> { where(deleted_at: nil) }
  end

  private

  def create_revision
    Revision.create(revisionable: self, metadata: to_json(except: %i[id created_at updated_at]))
  end
end
