class CreateCouncilWards < ActiveRecord::Migration[5.1]
  def change
    create_table :council_wards do |t|
      t.string :title
      t.timestamps
    end
  end
end
