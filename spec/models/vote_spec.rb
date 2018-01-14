describe Vote do
  let(:vote) { FactoryBot.build(:question_vote) }

  it 'has a valid factory' do
    expect(vote.save).to eq true
  end

  # context 'on deletion' do
  #   it 'is not found' do
  #     vote.deleted_at = Time.now
  #     vote.save
  #     expect { Vote.find(vote.id) }.to raise_error(ActiveRecord::RecordNotFound)
  #   end
  # end

  context 'on creation' do
    it 'creates revision' do
      vote.save
      expect(Revision.find_by(revisionable: vote)).not_to be_nil
    end
  end

  context 'on updation' do
    it 'creates revision' do
      vote.save
      vote.vote_type = [1, -1].sample
      vote.save
      expect(Revision.last.revisionable).to eq vote
    end
  end

  context 'on setting invalid attributes' do
    it 'is invalid without user' do
      vote.user = nil
      expect(vote.save).to eq false
    end

    it 'is invalid without vote_type' do
      vote.vote_type = nil
      expect(vote.save).to eq false
    end

    it 'is invalid without question' do
      vote.votable = nil
      expect(vote.save).to eq false
    end
  end
end

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
