describe Comment do
  let(:comment) { FactoryBot.build(:question_comment) }

  it 'has a valid factory' do
    expect(comment.save).to eq true
  end

  # context 'on deletion' do
  #   it 'is not found' do
  #     comment.deleted_at = Time.now
  #     comment.save
  #     expect { Comment.find(comment.id) }.to raise_error(ActiveRecord::RecordNotFound)
  #   end
  # end

  context 'on creation' do
    it 'creates revision' do
      comment.save
      expect(Revision.find_by(revisionable: comment)).not_to be_nil
    end
  end

  context 'on updation' do
    it 'creates revision' do
      comment.save
      comment.text = Faker::GameOfThrones.character
      comment.save
      expect(Revision.last.revisionable).to eq comment
    end
  end

  context 'on setting invalid attributes' do
    it 'is invalid without user' do
      comment.user = nil
      expect(comment.save).to eq false
    end

    it 'is invalid without text' do
      comment.text = nil
      expect(comment.save).to eq false
    end

    it 'is invalid without question' do
      comment.commentable = nil
      expect(comment.save).to eq false
    end
  end
end

# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  commentable_type :string           not null
#  commentable_id   :integer          not null
#  user_id          :integer          not null
#  text             :text             not null
#  deleted_at       :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_comments_on_commentable_type_and_commentable_id  (commentable_type,commentable_id)
#  index_comments_on_deleted_at                           (deleted_at)
#  index_comments_on_user_id                              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
