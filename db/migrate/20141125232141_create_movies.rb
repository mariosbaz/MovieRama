class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.integer :likes
      t.integer :hates

      t.timestamps
    end
  end
end
