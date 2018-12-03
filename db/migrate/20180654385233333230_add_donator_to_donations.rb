class AddDonatorToDonations < ActiveRecord::Migration[5.1]
  def change
  	add_column :donations, :donator_id, :integer 
  	add_column :donations, :donator_type, :string
  	add_index(:donations, [:donator_type, :donator_id])
  end
end
