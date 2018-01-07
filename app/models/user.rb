# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  email           :string           not null
#  password_digest :string
#  deleted_at      :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 50 }, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  has_many :questions, -> { where(deleted_at: nil) }
  has_many :answers, -> { where(deleted_at: nil) }
  has_many :comments, -> { where(deleted_at: nil) }
  has_many :votes, -> { where(deleted_at: nil) }
  has_many :sessions, -> { where(deleted_at: nil) }

  has_secure_password

  scope :active, -> { where(deleted_at: nil) }

  before_save { self.email = email.downcase }
end
