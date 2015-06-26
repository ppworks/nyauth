FactoryGirl.define do
  factory :user, class: 'User' do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password' }
    nickname { Faker::Name.name }

    trait :without_nickname do
      nickname nil
    end

    trait :requested_confirmation do
      confirmation_key 'key'
      confirmation_key_expired_at { Time.current + 1.hour }
    end

    trait :requested_reset_password do
      reset_password_key 'key'
      reset_password_key_expired_at { Time.current + 1.hour }
    end
  end
end
