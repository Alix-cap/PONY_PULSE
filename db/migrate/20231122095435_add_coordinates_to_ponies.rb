class AddCoordinatesToPonies < ActiveRecord::Migration[7.1]
  def change
    add_column :ponies, :latitude, :float
    add_column :ponies, :longitude, :float
  end
end
