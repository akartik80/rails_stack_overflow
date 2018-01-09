describe Question do
  let(:question) { FactoryBot.build(:question) }

  it 'has a valid factory' do
    expect(question.save).to eq true
  end

  # context 'on deletion' do
  #   it 'is not found' do
  #     question.deleted_at = Time.now
  #     question.save
  #     expect { Question.find(question.id) }.to raise_error(ActiveRecord::RecordNotFound)
  #   end
  # end

  context 'on creation' do
    it 'creates revision' do
      question.save
      expect(Revision.find_by(revisionable: question)).not_to be_nil
    end
  end

  context 'on updation' do
    it 'creates revision' do
      question.save
      question.text = Faker::GameOfThrones.character
      question.save
      expect(Revision.last.revisionable).to eq question
    end
  end

  context 'on setting invalid attributes' do
    it 'is invalid without user' do
      question.user = nil
      expect(question.save).to eq false
    end

    it 'is invalid without text' do
      question.text = nil
      expect(question.save).to eq false
    end
  end
end
