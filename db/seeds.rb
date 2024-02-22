# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# User0 Admin 😎
user0 = User.create(email: "user0@world.co",
            password: "123456",
            full_name: "user0 lastname",
            username: "user0")

# NPC Users
20.times do
  character = Faker::JapaneseMedia::OnePiece.unique.character
  avatar_url = Faker::Avatar.image
  bio = Faker::JapaneseMedia::OnePiece.unique.akuma_no_mi

  user = User.create(email: "#{character.gsub(/\s+/, "")}@world.co",
              password: "123456",
              full_name: character,
              username: character,
              avatar_url: avatar_url,
              bio: bio)

  user.followees << user0
  user.followers << user0
end

20.times do
  character = Faker::JapaneseMedia::Naruto.unique.character
  avatar_url = Faker::Avatar.image
  bio = Faker::JapaneseMedia::Naruto.village

  user = User.create(email: "#{character.gsub(/\s+/, "")}@world.co",
              password: "123456",
              full_name: character,
              username: character,
              avatar_url: avatar_url,
              bio: bio)

  user.followees << user0
  user.followers << user0
end

# Approve all follow requests
Follow.all.each do |f|
  f.toggle!(:approved)
end

# NPC Users create posts
User.all.each do |user|
  quote = Faker::JapaneseMedia::OnePiece.quote
  Post.create(body: quote, user_id: user.id)
end
