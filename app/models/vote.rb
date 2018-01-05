class Vote < ApplicationRecord
  validates_presence_of :votable, :user, :vote_type

  belongs_to :votable, polymorphic: true
  belongs_to :user
end
