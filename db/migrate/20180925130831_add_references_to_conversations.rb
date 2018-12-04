class AddReferencesToConversations < ActiveRecord::Migration[5.1]
  def change
    add_column :conversations, :fund_raiser_id, :integer
  end
end
