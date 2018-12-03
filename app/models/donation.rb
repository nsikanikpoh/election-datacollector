class Donation < ApplicationRecord
	enum line: [:monthly, :quarterly, :yearly]
  	belongs_to :donator, polymorphic: true
end
