class User < ApplicationRecord
  has_many :questions
  has_many :answers
  has_many :comments
  has_many :votes
  has_many :sessions

  validates_presence_of :name, :email
  validates_uniqueness_of :email, :salt

  validates :name, length: {maximum: 50}
  validates :email, length: {maximum: 50}
end
