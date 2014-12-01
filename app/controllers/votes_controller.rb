class VotesController < ApplicationController
  before_action :authenticate_user!

  def create    
    @movie = Movie.find(votes_params[:movie_id])       
    if @movie.user_id == current_user.id
      flash[:notice] = "Sorry you are the author you can't vote"
    elsif  find_vote(@movie)
      if @vote.vote_value.to_i == votes_params[:vote_value].to_i
        flash[:notice] = "You have already Voted. You can Unvote or switch vote"        
      else 
        change_vote        
        flash[:notice] = "Thanks for voting"
      end
    else
      @vote = current_user.votes.build(votes_params)
      like_or_hate     
      flash[:notice] = "Thanks for voting"
    end    
    redirect_to root_path
  end  

  def destroy
    @vote = Vote.find(params[:id])
    @movie = Movie.find(@vote.movie_id)
    if @vote.vote_value == 1 
      @movie.unlike
    elsif @vote.vote_value == 2
      @movie.unhate
    end     
    @vote.destroy
    @movie.save
    redirect_to root_path
    flash[:notice] = "Now you can Vote again"
  end 

  private
  def votes_params
    params.require(:vote).permit(:vote_value, :movie_id)
  end 

  def find_vote(movie)
    @vote = Vote.find_by(movie_id: movie.id, user_id: current_user.id)
  end
  
  def change_vote
    if @vote.vote_value == 1
      @movie.unlike
      @movie.hate
      @vote.vote_value = 2
    elsif @vote.vote_value == 2
      @movie.unhate
      @movie.like
      @vote.vote_value = 1
    end
    @vote.save
    @movie.save
  end

  def like_or_hate
    if @vote.vote_value == 1
      @movie.like
    elsif @vote.vote_value == 2
      @movie.hate
    end
    @vote.save
    @movie.save
  end

end
