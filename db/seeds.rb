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
            username: "user0",
            avatar_url: "")

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
4.times do
  User.all.each do |user|
    quote = Faker::TvShows::Spongebob.quote
    Post.create(body: quote, user_id: user.id)
  end
end

Post.all.each do |post|
  3.times do
    user = User.all.sample
    city = Faker::Games::ElderScrolls.city
    creature = Faker::Games::ElderScrolls.creature
    adjective = Faker::Adjective.positive

    user.comments.create!(body: "Hi I am from #{city}, I send my #{adjective} #{creature}, enjoy!", post_id: post.id)
  end
end

#Create a lot of comments for pagination testing
last_post = Post.last
50.times do |i|
  last_post.comments.create(user_id: user0.id, body: "Parent comment #{i}")
end

#Create a lot of subcomments for pagination testing
last_comment = last_post.comments.last

50.times do |i|
  last_post.comments.create(user_id: user0.id, body: "Child comment #{i}", parent_id: last_comment.id, depth: 1)
end

#Create a lot of likes for fun?
last_post.comments.each do |comment|
  comment.poly_likes.create(user_id: user0.id)
end
