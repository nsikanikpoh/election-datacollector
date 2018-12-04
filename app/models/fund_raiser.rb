class FundRaiser < User	
 	has_many :prospects
 	has_many :conversations, foreign_key: :fund_raiser_id
end
