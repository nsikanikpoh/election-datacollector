class CreateQuickDonations < ActiveRecord::Migration[5.1]
  def change
    create_table :quick_donations do |t|
    	t.string :name
      t.string :tel
      t.string :email
      t.float :amount

      t.timestamps
    end
  end
end
