FactoryBot.define do
  factory :comment do |f|
    f.text Faker::GameOfThrones.character
    association :commentable
    user
  end
end
