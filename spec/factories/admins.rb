FactoryGirl.define do
  factory :admin, class: 'Admin' do
    sequence(:email) { |n| "admin#{n}@example.com" }
    password { 'password' }
  end
end
