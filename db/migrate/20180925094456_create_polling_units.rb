class CreatePollingUnits < ActiveRecord::Migration[5.1]
  def change
    create_table :polling_units do |t|
      t.string :title
      t.timestamps
    end
  end
end
