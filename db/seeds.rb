require 'faker'

[User, Article, Comment, Like].each(&:delete_all)

puts 'Creating users...'
10.times do |index|
  puts "Creating user ##{index}"

  password = 'password'

  User.create(
    email: Faker::Internet.email,
    password: password,
    password_confirmation: password,
    lastname: Faker::Name.last_name,
    firstname: Faker::Name.first_name,
    birth_date: Faker::Date.birthday(min_age: 18, max_age: 65)
  )
end

puts 'Creating articles...'
User.all.each do |user|
  rand(1..User.count).times do
    puts "Creating article for user ##{user.id}"
    user.articles.create(
      title: Faker::Lorem.sentence,
      body: Faker::Lorem.paragraph,
      published: Faker::Boolean.boolean
    )
  end
end

puts 'Creating likes...'
Article.all.each do |article|
  User.all.sample(5).each do |user|
    puts "Creating like for article ##{article.id} by user ##{user.id}"
    article.likes.create(user: user, rating: Faker::Number.between(from: 1, to: 5))
  end
end

puts 'Creating comments...'
Article.all.each do |article|
  User.all.sample(5).each do |user|
    puts "Creating comment for article ##{article.id} by user ##{user.id}"
    article.comments.create(user: user, body: Faker::Lorem.sentence)
  end
end
