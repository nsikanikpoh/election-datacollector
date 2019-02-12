class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|

    	t.string  :election_type 
    	t.string  :lga 
    	t.time  :arrival_time
    	t.time  :arrival_election_material
    	t.time  :voting_started
         t.time  :voting_ended
    	t.integer :all_voters, :limit => 8
    	t.integer :valid_voters, :limit => 8
    	t.integer :invalid_voters, :limit => 8
    	t.integer :apc_votes, :limit => 8
    	t.integer :apga_votes, :limit => 8
    	t.integer :labour_party, :limit => 8
    	t.integer :pdp_votes, :limit => 8
    	t.integer :prp_votes, :limit => 8
    	t.integer :ypp_votes, :limit => 8
    	t.integer :total_votes, :limit => 8
    	t.time :result_time 
    	t.string :pdp_agent 
    	t.string :agent_phone
      t.string :officer_name  
    	t.string :officer_gender 
    	t.string :picture 
    	t.string :sheet 
    	t.float :latitude 
    	t.float :longitude
      t.references :council_ward, foreign_key: true
      t.references :polling_unit, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
