# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  votable_type :string           not null
#  votable_id   :integer          not null
#  user_id      :integer          not null
#  vote_type    :integer          not null
#  deleted_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_votes_on_deleted_at                   (deleted_at)
#  index_votes_on_user_id                      (user_id)
#  index_votes_on_votable_type_and_votable_id  (votable_type,votable_id)
#  index_votes_on_vote_type                    (vote_type)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
