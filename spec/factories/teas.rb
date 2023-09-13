FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Lorem.sentence }
    temperature { Faker::Number.between(from: 100, to: 212) }
    brew_time { Faker::Number.between(from: 3, to: 5) }
  end
end