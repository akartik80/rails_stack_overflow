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

  validates_presence_of :name, :email
  validates_uniqueness_of :email

  validates :name, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 50 }, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  # validates :password, presence: true

  has_many :questions
  has_many :answers
  has_many :comments
  has_many :votes
  has_many :sessions

  has_secure_password

  scope :active, -> { where(deleted_at: nil) }

  # before_save { self.email = email.downcase }
  # has_secure_password
end
