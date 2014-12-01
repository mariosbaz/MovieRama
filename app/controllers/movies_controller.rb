class MoviesController < ApplicationController
  before_action :find_movie, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  helper_method :sort_column, :sort_direction

  def new
    @movie = Movie.new
  end

  def index  
    @filter = params[:id]
    if @filter 
      @movies = Movie.where(user_id: @filter ).order(
        sort_column + " " + sort_direction).paginate(page: params[:page])
    else
      @movies = Movie.order(
      sort_column + " " + sort_direction).paginate(page: params[:page])
    end
  end

  def update
    if @movie.user_id == current_user.id
      if @movie.update_attributes(movie_params)
        flash[:success] = "Movie Updated"
        redirect_to @movie        
      else 
        render "edit"
      end
    else
      redirect_to @movie        
    end
  end

  def create
    @movie = current_user.movies.build(movie_params)
    if @movie.save
      redirect_to root_path
    else
      render 'new'
    end    
  end

  def destroy
    if @movie.user_id == current_user.id
      @movie.destroy
    end
    redirect_to action: 'index'
  end

  private

  def find_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :description)
  end  
  
  def sort_column
    Movie.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
