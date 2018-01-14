describe Session do
  let(:session) { FactoryBot.build(:session) }

  it 'has a valid factory' do
    expect(session.save).to eq true
  end

  context 'on setting invalid attributes' do
    it 'is invalid without user' do
      session.user = nil
      expect(session.save).to eq false
    end

    it 'is invalid without token' do
      session.token = nil
      expect(session.save).to eq false
    end
  end
end

# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  token      :string           not null
#  deleted_at :datetime
#  expired_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_sessions_on_deleted_at  (deleted_at)
#  index_sessions_on_expired_at  (expired_at)
#  index_sessions_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
