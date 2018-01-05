class Revision < ApplicationRecord
  belongs_to :revisionable, polymorphic: true

  validates_presence_of :revisionable_type, :revisionable_id
end
