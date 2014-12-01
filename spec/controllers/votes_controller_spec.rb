require 'spec_helper'

describe VotesController do 

  describe 'authenticated users' do 
    before  do 
      @user = create(:user)
      sign_in @user
      @movie = create(:movie)
      @like_vote = create(:like_vote, movie: @movie)
      @hate_vote = create(:hate_vote, movie: @movie)
    end

    describe "POST #create" do

      context "with valid attributes" do
        it "saves the vote value in the database" do
          expect{
            post :create, vote: attributes_for(:like_vote, 
              movie_id: @movie.id, user_id: @user.id)
          }.to change(Vote, :count).by(1)
        end

        it "adds 1 to Movie.likes if like" do           
          post :create, vote: attributes_for(:like_vote, 
            movie_id: @movie.id, user_id: @user.id)
          @movie.reload
          expect(@movie.likes).to eq(2)
        end

        it "adds 1 to Movie.hates if hate" do           
          post :create, vote: attributes_for(:hate_vote, 
            movie_id: @movie.id, user: @user)
          @movie.reload
          expect(@movie.hates).to eq(2)
        end

        it "redirects correctly" do
          post :create, vote: attributes_for(:like_vote, 
          movie_id: @movie.id, user: @user)          
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "DELETE #destroy" do 

      it "deletes the vote" do 
        expect{ delete :destroy, id: @like_vote 
          }.to change(Vote, :count).by(-1)
      end
      
      it "subtracks 1 from Movie model if like deleted" do 
        expect(@movie.likes).to eq (1)
        delete :destroy, id: @like_vote
        @movie.reload
        expect(@movie.likes).to eq(0)
      end

      it "adds 1 to Movie model if hate deleted" do
        expect(@movie.hates).to eq(1)
        delete :destroy, id: @hate_vote
        @movie.reload
        expect(@movie.hates).to eq(0)
      end

      it "redirects to the movies index" do 
        delete :destroy, id: @like_vote
        expect(response).to redirect_to root_path
      end
    end
  end  
end