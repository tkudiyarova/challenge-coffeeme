FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User_#{n}" }
  end
end
