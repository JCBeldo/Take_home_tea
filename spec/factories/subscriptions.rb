FactoryBot.define do
  factory :subscription do
    title  { Faker::Subscription.plan }
    price  { Faker::Number.between(from: 20, to: 100) }
    status { Faker::Subscription.status }
    frequency { Faker::Subscription.subscription_term }
  end
end