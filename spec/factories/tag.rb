FactoryBot.define do
  factory :tag do |f|
    f.text Faker::Bitcoin.address
    f.description Faker::HarryPotter.quote
  end
end
