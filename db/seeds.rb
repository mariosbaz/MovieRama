# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

(1..10).each do |i|
  User.create(email: "test_#{i}@user.com", name:"test_#{i}",
   password: "foobar", password_confirmation: "foobar")
end


User.order(:created_at).take(6).each do |user|
  (1..50).each do |i|
    user.movies.create!(title: "movie_#{i}", 
      description: Faker::Lorem.paragraph)	  
  end
end
