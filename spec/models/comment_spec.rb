describe Comment do
  # it 'has a valid factory' do
  #   expect(FactoryBot.create(:comment)).to be_valid
  # end

  # context 'deleted comment' do
  #   it 'is not found if deleted' do
  #     comment = FactoryBot.create(:comment)
  #     comment.deleted_at = Time.now
  #     comment.save!
  #     expect(Comment.find_by(id: comment.id)).to be_nil
  #   end
  # end
  #
  # context 'create revisions on create and update' do
  #   it 'creates revision on create' do
  #     comment = FactoryBot.create(:comment)
  #     expect(Revision.find_by(revisionable: comment)).not_to be_nil
  #   end
  #
  #   it 'creates revision on update' do
  #     comment = FactoryBot.create(:comment)
  #     comment.text = 'bla'
  #     comment.save!
  #     expect(Revision.last.revisionable).to eq comment
  #   end
  # end
end
