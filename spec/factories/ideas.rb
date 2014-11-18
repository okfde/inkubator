FactoryGirl.define do
  factory :idea do
    title "Test"
    description Faker::Lorem.sentence(3)
    problem Faker::Lorem.sentence(10)
    goal Faker::Lorem.sentence(15)
    impact Faker::Lorem.sentence(15)
    user
  end
end
