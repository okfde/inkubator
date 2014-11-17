FactoryGirl.define do
  factory :user do
    username "Test"
    email "test@test.de"
    password "abcdefghi1234"
    after(:build) { |u| u.password_confirmation = u.password }
  end
end
