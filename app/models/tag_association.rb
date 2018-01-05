class TagAssociation < ApplicationRecord
  belongs_to :tag, null: false
  belongs_to :taggable, polymorphic: true

  validates_presence_of :tag_id, :taggable_type, :taggable_id
end
