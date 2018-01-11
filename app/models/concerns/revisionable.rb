module Revisionable
  extend ActiveSupport::Concern

  included do
    def self.revisionable
      has_many :revisions, as: :revisionable
      after_save :create_revision
    end

    def create_revision
      Revision.create(revisionable: self, metadata: to_json(except: %i[id created_at updated_at]))
    end
  end
end
