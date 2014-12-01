require 'spec_helper'

describe MoviesController do

  describe 'authenticated users' do 
    before :each do
      @user = create(:user)
      sign_in @user
      @movie = create(:movie, user: @user)   
    end 

    describe 'GET #new' do
      it "assigns a new Movie to @movie" do
        get :new
        expect(assigns(:movie)).to be_a_new(Movie)
      end

      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end   

    describe 'GET #index' do 
      it "populates an array of all movies" do
        movie1 = create(:movie)
        movie2 = create(:movie)
        get :index
        expect(assigns(:movies)).to match_array([movie1, movie2, @movie])
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index      
      end
    end

    describe 'GET #edit' do    
      it "assigns the requested movie to @movie" do
        get :edit, id: @movie
        expect(assigns(:movie)).to eq @movie
      end

      it "renders the :edit template" do
        get :edit, id: @movie
        expect(response).to render_template :edit
      end
    end

    describe 'POST #create' do
      context "with valid attributes" do
        it "saves the new movie in the database" do
          expect{ 
            post :create, movie: attributes_for(:movie) 
            }.to change(Movie, :count).by(1)
        end

        it "redirects to movies#index" do
          post :create, movie: attributes_for(:movie)
          expect(response).to redirect_to root_path
        end
      end

      context "with invalid attributes" do
        it "doesn't save the new movie in the database" do
          expect{
           post :create, movie: attributes_for(:invalid_movie)
           }.not_to change(Movie, :count)
        end

        it "re-renders the :new template" do
          post :create, movie: attributes_for(:invalid_movie)
          expect(response).to render_template :new
        end
      end
    end

    describe 'PATCH #update' do
      context "valid attributes" do
        it "locates the requested @movie" do
          patch :update, id: @movie, movie: attributes_for(:movie)
          expect(assigns(:movie)).to eq(@movie)
        end

        it "changes @movie's attributes" do
          patch :update, id: @movie, movie: attributes_for(:movie,
            title: 'valid test', user: @user)
          expect(@movie.title).to eq('test')
          @movie.reload
          expect(@movie.title).to eq('valid test')
        end

        it "redirects to the updated contact" do
          patch :update, id: @movie, movie: attributes_for(:movie)
          expect(response).to redirect_to @movie
        end
      end

      context "invalid attributes" do
        it 'does not change the @movies attributes' do
          patch :update, id: @movie, movie: attributes_for(:invalid_movie, 
            user: @user) 
          expect(@movie.title).to eq('test')
          @movie.reload
          expect(@movie.title).to eq('test')
        end

        it "re-renders to the :edit template" do 
          patch :update, id: @movie, movie: attributes_for(:invalid_movie, 
            user: @user)
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do   
      context "valid attributes" do 
        it "deletes the movie" do
          expect{ delete :destroy, id: @movie
        }.to change(Movie,:count).by(-1)
        end

        it "redirects to movies#index" do
          delete :destroy, id: @movie
          expect(response).to redirect_to movies_url
        end
      end

      context "invalid attributes" do 
        before :each do 
          @another_user = create(:user) 
          sign_in @another_user
        end

        it "deletes the movie" do
          expect{ delete :destroy, id: @movie
        }.to_not change(Movie, :count)
        end

        it "redirects to movies#index" do
          delete :destroy, id: @movie
          expect(response).to redirect_to movies_url
        end
      end
    end
  end

  describe 'guests' do    
    # GET #index  examples are the same as for authenticated users
    describe 'GET #new' do
      it 'requires login' do
        get :new
        expect(response).to redirect_to new_user_session_url
      end
    end

    describe 'GET #edit' do
      it "requires login" do
        movie = create(:movie)
        get :edit, id: movie
        expect(response).to redirect_to new_user_session_url
      end
    end

    describe "POST #create" do
      it "requires login" do
        post :create, id: create(:movie),
          movie: attributes_for(:movie)
        expect(response).to redirect_to new_user_session_url
      end
    end
    
    describe 'PATCH #update' do
      it "requires login" do
        put :update, id: create(:movie),
          movie: attributes_for(:movie)
        expect(response).to redirect_to new_user_session_url
      end
    end

    describe 'DELETE #destroy' do
      it "requires login" do
        delete :destroy, id: create(:movie)
        expect(response).to redirect_to new_user_session_url
      end
    end   
  end
end 