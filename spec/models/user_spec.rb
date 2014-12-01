require 'spec_helper'

describe User do

  let(:user) { create(:user) }
  
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "responds correctly" do 
    expect(user).to respond_to(:movies, :votes, :name)    
  end

end