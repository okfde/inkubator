FactoryGirl.define do
  factory :idea do
    title "Test"
    description Faker::Lorem.sentence(3)
    problem Faker::Lorem.words(195)
    goal Faker::Lorem.words(195)
    impact Faker::Lorem.words(195)
    user
  end
end
