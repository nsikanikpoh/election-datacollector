class AddInterestLineIdToDonations < ActiveRecord::Migration[5.1]
  def change
    add_column :donations, :interest_line_id, :integer
  end
end
