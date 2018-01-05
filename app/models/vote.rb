class Vote < ApplicationRecord
  belongs_to :votable, polymorphic: true
  belongs_to :user

  validates_presence_of :votable_type, :votable_id, :user_id, :vote_type
end
