class CreateInterestLines < ActiveRecord::Migration[5.1]
  def change
    create_table :interest_lines do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
