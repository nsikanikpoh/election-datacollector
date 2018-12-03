require "user"
class Ambassador < User	
    belongs_to :interest_line, foreign_key: :interest_line_id
    has_many :donations, as: :donator, foreign_key: :donator_id
end