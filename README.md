# Odinbook

[Project Link](https://www.theodinproject.com/lessons/ruby-on-rails-rails-final-project)

[Live Link](#)

## Introduction
Social media app

## Project Description
A user can make posts and comments; like posts or comments, and follow other users

1. Bulma 1.0 for styling
2. Turbo frames and streams for faster navigation
3. Pagy gem for pagination and infinite scroll
4. Devise and Google Oauth for authentication
5. Figaro gem for environment variables, Faker gem for seeding, 


## Requirements
* Ruby 3.1.2
* Rails 7.0.8
* PostgreSQL 14.11
* Yarn 1.22.19
* Ubuntu 22.04

## Setup
1. ```bundle install```
2. ```rails css:install:bulma```
3. ```rails db:seed```
4. ```./bin/dev```

* login as user0
  1. email: user0@world.co
  2. password: 123456
* OR
* login with google Oauth

## TODO
* Notifications for each new follow, comment
* stimulus components: character counter, Stimulus Timeago (better date format?), need a modal for the notifications as it is annoying and moves content.
* Add Posts Comments Likes Menu on user profile.
