describe Answer do
  let(:answer) { FactoryBot.build(:answer) }

  it 'has a valid factory' do
    expect(answer.save).to eq true
  end

  # context 'on deletion' do
  #   it 'is not found' do
  #     answer.deleted_at = Time.now
  #     answer.save
  #     expect { Answer.find(answer.id) }.to raise_error(ActiveRecord::RecordNotFound)
  #   end
  # end

  context 'on creation' do
    it 'creates revision' do
      answer.save
      expect(Revision.find_by(revisionable: answer)).not_to be_nil
    end
  end

  context 'on updation' do
    it 'creates revision' do
      answer.save
      answer.text = Faker::GameOfThrones.character
      answer.save
      expect(Revision.last.revisionable).to eq answer
    end
  end

  context 'on setting invalid attributes' do
    it 'is invalid without user' do
      answer.user = nil
      expect(answer.save).to eq false
    end

    it 'is invalid without text' do
      answer.text = nil
      expect(answer.save).to eq false
    end

    it 'is invalid without question' do
      answer.question = nil
      expect(answer.save).to eq false
    end
  end
end
