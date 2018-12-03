class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :commenter, polymorphic: true
  mount_uploader :attachment, AttachmentUploader
end
