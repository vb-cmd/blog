FactoryBot.define do
  factory :user, class: User do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    birth_date { Faker::Date.birthday }
  end

  factory :invalid_user, class: User do
    email { nil }
    password { nil }
    password_confirmation { nil }
    firstname { nil }
    lastname { nil }
    birth_date { nil }
  end
end
