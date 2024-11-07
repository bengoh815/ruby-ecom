FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password" }
    role { "regular" }

    # Create an admin trait for the admin user
    trait :admin do
      role { "admin" }
    end
  end
end