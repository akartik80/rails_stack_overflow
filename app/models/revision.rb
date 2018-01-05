class Revision < ApplicationRecord
  validates_presence_of :revisionable

  belongs_to :revisionable, polymorphic: true
end
