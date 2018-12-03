class CreateConversations < ActiveRecord::Migration[5.1]
  def change
    create_table :conversations do |t|
      
      t.text :body

      t.timestamps
    end
  end
end
