class AddReferencesToConversations < ActiveRecord::Migration[5.1]
  def change
    add_reference :conversations, :fund_raiser, foreign_key: true
  end
end
