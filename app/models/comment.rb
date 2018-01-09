# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  commentable_type :string           not null
#  commentable_id   :integer          not null
#  user_id          :integer          not null
#  text             :text
#  deleted_at       :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Comment < ApplicationRecord
  validates_presence_of :commentable, :user, :text

  revisionable
  soft_deletable

  belongs_to :commentable, polymorphic: true
  belongs_to :user
end
