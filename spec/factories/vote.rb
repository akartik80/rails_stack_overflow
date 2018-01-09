FactoryBot.define do
  factory :question_vote, class: 'vote' do |f|
    f.vote_type [1, -1].sample
    user
    association :votable, factory: :question
  end
end
