class AddLgaToPollingUnits < ActiveRecord::Migration[5.1]
  def change
    add_column :polling_units, :lga, :string
  end
end
