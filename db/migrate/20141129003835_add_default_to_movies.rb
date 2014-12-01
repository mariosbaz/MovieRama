class AddDefaultToMovies < ActiveRecord::Migration
 def change
  	remove_column :movies, :likes, :integer
  	remove_column :movies, :hates, :integer
  	add_column :movies, :likes, :integer, default: "0"
  	add_column :movies, :hates, :integer, default: "0"
  end
end
