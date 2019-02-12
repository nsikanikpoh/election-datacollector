class AddLgaToCouncilWards < ActiveRecord::Migration[5.1]
  def change
    add_column :council_wards, :lga, :string
  end
end
