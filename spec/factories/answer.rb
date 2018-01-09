FactoryBot.define do
  factory :answer do |f|
    f.text Faker::GameOfThrones.character
    question
    user

    after(:create) do |answer|
      create(:comment, commentable: answer)
    end
  end
end
