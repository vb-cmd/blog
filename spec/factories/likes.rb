FactoryBot.define do
  factory :like do
    rating { Faker::Number.between(from: 1, to: 5) }
    association :article
    association :user
  end
end
