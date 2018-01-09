FactoryBot.define do
  factory :answer do |f|
    f.text Faker::GameOfThrones.character
    question
    user
  end
end
