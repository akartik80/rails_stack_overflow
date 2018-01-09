FactoryBot.define do
  factory :question_comment, class: 'comment' do |f|
    f.text Faker::GameOfThrones.character
    user
    association :commentable, factory: :question
  end
end
