require 'faker'

FactoryGirl.define do
  factory :movie do
    title "test"
    description { Faker::Lorem.paragraph }
    likes 1
    hates 1        
    user

    factory :valid_movie do
      title "valid"
    end
    factory :invalid_movie do
      title nil
    end
  end
end