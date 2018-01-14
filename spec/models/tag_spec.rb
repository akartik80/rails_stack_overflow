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
