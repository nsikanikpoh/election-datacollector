class AddRefToUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :referrer_code, :integer
    add_column :users, :affiliate_code, :integer
  end
end
