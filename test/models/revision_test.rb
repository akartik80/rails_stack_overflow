# == Schema Information
#
# Table name: revisions
#
#  id                :integer          not null, primary key
#  revisionable_type :string           not null
#  revisionable_id   :integer          not null
#  metadata          :jsonb
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class RevisionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
