class AddProspectToConversation < ActiveRecord::Migration[5.1]
  def change
  	add_column :conversations, :pros_id, :integer 
  	add_column :conversations, :pros_type, :string
  	add_index(:conversations, [:pros_type, :pros_id])
  end
end
