class Sponsorship < Donation	
    belongs_to :interest_line, foreign_key: :interest_line_id 
end
