require 'spec_helper'

describe Movie do
  let(:user) { create(:user) }  
  let(:movie) { create(:movie, user: user) }
  
  it "responds correctly" do
  	expect(movie).to respond_to(:title, :description, :likes, :hates,
      :user_id, :like, :hate, :unlike, :unhate, :votes) 
  end

  it "is valid with a title, description and user_id" do
    expect(movie).to be_valid
  end

  it "is invalid without a title" do
    expect(build(:movie, user: user, title: nil)).to have(1).errors_on(:title)
  end

  it "is larger than 25 characters" do
    expect(build(:movie, user: user, title: "a"*26)).to have(1).errors_on(:title)
  end

  it "has a description larger than 500 characters" do
    expect(build(:movie, user: user, description: "a"*501)).to have(1).errors_on(:description)
  end

  it "doesn't belong to someone" do
  	expect(build(:movie, user_id: nil)).to have(1).errors_on(:user_id)
  end
  
  describe "destroy association" do
  
    before { @movie = create(:movie, user: user) }

    it "finds the associated movie in the db before deleting user" do 
      expect(Movie.find(@movie.id)).not_to eq nil 
    end

    it "is destroyed when the author is destroyed" do
      movies = user.movies.to_a
      user.destroy
      expect(movies).not_to be_empty
      movies.each do |movie|
        expect(Movie.where(id: movie.id)).to be_empty
      end
    end
  end

  describe "movie methods" do
    let(:movie) { create(:movie, likes: 0, hates: 0) }

    it "corresponds to the like method" do
      movie.like
      expect(movie.likes).to eq(1)
    end

    it "corresponds to the hate method" do
      movie.hate
      expect(movie.hates).to eq(1)
    end

    it "corresponds to the unlike method" do
      movie.unlike
      expect(movie.likes).to eq(-1)
    end

    it "corresponds to the unhate method" do
      movie.unhate
      expect(movie.hates).to eq(-1)
    end
  end
end

