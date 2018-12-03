class Collage < ApplicationRecord
	has_many :pics, dependent: :destroy, inverse_of: :collage
	 accepts_nested_attributes_for :pics, 
	 								allow_destroy: true, 
	 								reject_if: :all_blank

	

end