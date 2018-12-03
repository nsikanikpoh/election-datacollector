class AddOpportunityToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :opportunity, :integer
    add_column :users, :fundraiser_email, :string
  end
end
