class Session < ApplicationRecord
  validates_presence_of :user, :token
  scope :active, -> { where(deleted_at: nil) }

  belongs_to :user
end
