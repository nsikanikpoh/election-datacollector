class Member < User	
 has_many :donations, as: :donator, foreign_key: :donator_id
end
