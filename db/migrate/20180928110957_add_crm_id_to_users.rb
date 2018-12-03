class AddCrmIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :crm_id, :string
  end
end
