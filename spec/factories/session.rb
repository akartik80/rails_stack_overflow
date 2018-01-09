FactoryBot.define do
  factory :session do |f|
    f.token Faker::Bitcoin.address
    user
  end
end
