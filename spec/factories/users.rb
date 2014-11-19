FactoryGirl.define do
  factory :user do
    username "Test"
    sequence(:email)      { |n| "person_#{n}@example.com" }
    password "abcdefghi1234"
    role "board"
    after(:build) { |u| u.password_confirmation = u.password }
  end
  factory :admin, class: User do
    username "Test"
    email "admin@admin.com"
    password "abcdefghi1234"
    role "superadmin"
    after(:build) { |u| u.password_confirmation = u.password }
  end
end
