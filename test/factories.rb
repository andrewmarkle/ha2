FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :company do
    sequence(:name) { |n| "Company_#{n}" }
    url 'http://houndinc.com'
  end

  factory :plan do
    sequence(:name) { |n| "plan_#{n}" }
    interval 10
    price_per_walk 2500
  end
end
