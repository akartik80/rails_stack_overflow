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
