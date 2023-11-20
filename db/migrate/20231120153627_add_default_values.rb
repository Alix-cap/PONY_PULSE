class AddDefaultValues < ActiveRecord::Migration[7.1]
  def change
    change_column :bookings, :status, :string, default: "pending"
    change_column :users, :role, :string, default: "renter"
  end
end
