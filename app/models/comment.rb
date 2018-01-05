class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :revisions, as: :revisionable, dependent: destroy
end
