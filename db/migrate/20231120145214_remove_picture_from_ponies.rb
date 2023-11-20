class RemovePictureFromPonies < ActiveRecord::Migration[7.1]
  def change
    remove_column :ponies, :picture
  end
end
