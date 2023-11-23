class ChangeDatesToStrings < ActiveRecord::Migration[7.1]
  def change
    change_column :bookings, :start_date, :string
    change_column :bookings, :end_date, :string
    change_column :ponies, :birth_date, :string
  end
end
