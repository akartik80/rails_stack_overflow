class Comment < ApplicationRecord
  revisionable
  soft_deletable

  validates_presence_of :commentable, :user, :text

  belongs_to :commentable, polymorphic: true
  belongs_to :user
end

# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  commentable_type :string           not null
#  commentable_id   :integer          not null
#  user_id          :integer          not null
#  text             :text             not null
#  deleted_at       :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_comments_on_commentable_type_and_commentable_id  (commentable_type,commentable_id)
#  index_comments_on_deleted_at                           (deleted_at)
#  index_comments_on_user_id                              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
