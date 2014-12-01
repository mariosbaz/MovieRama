require 'spec_helper'

describe Vote do

  let(:vote) { create(:vote) }
  
  it "has a valid factory" do
    expect(build(:vote)).to be_valid
  end

  it "responds correctly" do 
    expect(vote).to respond_to(:vote_value, :user_id, :movie_id)    
  end

  it "has a present user id" do
    expect(build(:vote, user_id: nil)).to have(1).errors_on(:user_id) 
  end
  
  it "has a present movie id" do
    expect(build(:vote, movie_id: nil)).to have(1).errors_on(:movie_id) 
  end
end