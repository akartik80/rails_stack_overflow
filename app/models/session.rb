class Session < ApplicationRecord
  validates_presence_of :user, :token

  belongs_to :user
end
