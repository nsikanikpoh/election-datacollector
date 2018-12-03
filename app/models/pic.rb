class Pic < ApplicationRecord
	belongs_to :collage
	mount_uploader :picture, PictureUploader
end
