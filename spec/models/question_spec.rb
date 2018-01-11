describe Question do
  let(:question) { FactoryBot.create(:question) }

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
    it 'should not create revision' do
      expect(Revision.count).to eq(0)
      question
      expect(Revision.count).to eq(0)
      # expect(Revision.find_by(revisionable: question)).not_to be_nil
    end
  end

  context 'on updation' do
    it 'should creates revision' do
      question
      expect(Revision.count).to eq(0)
      question.update_attributes(text: 'some random text')
      expect(Revision.count).to eq(1)
      expect(Revision.where(revisable: question).present?).to be true
    end
  end

  describe 'validations' do
    describe 'presence of user' do
      context 'if user is not present' do
        it 'should invalidate model' do

        end
      end
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
