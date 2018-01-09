describe Tag do
  let(:tag) { FactoryBot.build(:tag) }

  it 'has a valid factory' do
    expect(tag.save).to eq true
  end

  context 'on setting invalid attributes' do
    it 'is invalid without text' do
      tag.text = nil
      expect(tag.save).to eq false
    end
  end
end
