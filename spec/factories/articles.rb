FactoryBot.define do
  factory :article, class: Article do
    association :user
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    published { Faker::Boolean.boolean }
  end

  factory :invalid_article, class: Article do
    user { nil }
    title { nil }
    body { nil }
    published { nil }
  end
end
