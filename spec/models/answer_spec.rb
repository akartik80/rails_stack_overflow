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

# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  question_id :integer          not null
#  user_id     :integer          not null
#  text        :text             not null
#  accepted    :boolean          default(FALSE)
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_answers_on_deleted_at   (deleted_at)
#  index_answers_on_question_id  (question_id)
#  index_answers_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#  fk_rails_...  (user_id => users.id)
#
