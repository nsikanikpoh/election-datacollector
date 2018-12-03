class AddExpiresOnToDonations < ActiveRecord::Migration[5.1]
  def change
    add_column :donations, :expires_on, :date
  end
end
