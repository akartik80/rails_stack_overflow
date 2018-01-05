class Session < ApplicationRecord
  belongs_to :user

  validates_presence_of :user_id, :token
end
