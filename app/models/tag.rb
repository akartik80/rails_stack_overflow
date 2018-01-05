class Tag < ApplicationRecord
  has_many :tag_associations
  has_many :questions, through: :tag_associations, source: :taggable, source_type: 'Question'

  validates_presence_of :text
end
