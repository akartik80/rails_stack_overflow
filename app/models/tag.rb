class Tag < ApplicationRecord
  validates_presence_of :text

  has_and_belongs_to_many :questions
end

# == Schema Information
#
# Table name: tags
#
#  id          :integer          not null, primary key
#  text        :string           not null
#  description :text
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_tags_on_deleted_at  (deleted_at)
#
