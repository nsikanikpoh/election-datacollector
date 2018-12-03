class AddSTypeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :s_type, :string, null: false, default: "Member"
  end
end
