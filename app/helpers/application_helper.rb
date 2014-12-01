module ApplicationHelper
	
  def find_vote (movie)
    @vote = Vote.find_by(movie_id: movie.id, user_id: current_user.id)
  end

  def sortable (column, title = nil, user = nil)
  	title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
  	link_to title, sort: column, direction: direction, id: user
  end

  def filterable (name)
    id = User.find_by(name: name).id
    link_to name, id: id
  end
end
