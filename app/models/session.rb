# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  token      :string           not null
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Session < ApplicationRecord
  validates_presence_of :user, :token
  scope :active, -> { where(deleted_at: nil) }

  belongs_to :user
end
