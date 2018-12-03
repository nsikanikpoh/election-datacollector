class Prospect < User
	enum opportunity: [:None, :Found]
    belongs_to :fund_raiser, foreign_key: :fund_raiser_id
    has_many :conversations, as: :pros, foreign_key: :pros_id, dependent: :destroy
end
