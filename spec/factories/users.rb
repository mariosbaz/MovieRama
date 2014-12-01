require 'faker'

FactoryGirl.define do
  factory :user do
  	sequence(:email) { |n| "test#{n}@example.com"}
    password "rubyruby"
    password_confirmation "rubyruby"
  end 
end