FactoryBot.define do
  factory :question do |f|
    f.text Faker::GameOfThrones.character
    user

    after(:create) do |question|
      create(:comment, commentable: question)
    end
  end
end
