class AddTypetoDonations < ActiveRecord::Migration[5.1]
  def change
    add_column :donations, :type, :string
  end
end
