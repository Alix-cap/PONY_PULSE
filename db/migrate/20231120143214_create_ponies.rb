class CreatePonies < ActiveRecord::Migration[7.1]
  def change
    create_table :ponies do |t|
      t.string :name
      t.string :race
      t.string :location
      t.date :birth_date
      t.string :sex
      t.string :picture
      t.string :purpose
      t.string :coat
      t.float :price_per_day
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
