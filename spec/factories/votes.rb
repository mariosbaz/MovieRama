FactoryGirl.define do
  factory :vote do
    user
    movie
    vote_value 1

    factory :like_vote do
      vote_value 1
    end

    factory :hate_vote do
      vote_value 2
    end

    factory :invalid_vote do
      vote_value nil
    end
  end
end
