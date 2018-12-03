class Champion < User	
 	has_many :donations, as: :donator, foreign_key: :donator_id
 	has_many :posts
end