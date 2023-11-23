class AddDescriptionToPony < ActiveRecord::Migration[7.1]
  def change
    add_column :ponies, :description, :text
  end
end
