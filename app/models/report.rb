class Report < ApplicationRecord
	
	mount_uploader :picture, PictureUploader
	mount_uploader :sheet, SheetUploader
	belongs_to :council_ward
	belongs_to :user
	belongs_to :polling_unit
	
	after_validation :cord


	def full_address
		 ["Jere", "Abuja", "FCT", "NG"].compact.join(', ')
	end


	def cord
		location = ["NG","FCT","Abuja","Jere"].compact.join(', ')

		location = Geocoder.search(location)
  		
  		
		self.latitude = location[0].latitude unless latitude.present?
		self.longitude = location[0].longitude unless longitude.present?

	end

end