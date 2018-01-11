module SoftDeletable
  extend ActiveSupport::Concern

  included do
    def self.soft_deletable
      default_scope -> { where(deleted_at: nil) }
    end
  end
end
