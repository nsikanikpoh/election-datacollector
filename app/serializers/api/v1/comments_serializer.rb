class Api::V1::CommentsSerializer < ActiveModel::Serializer
   attributes :id, :body
   belongs_to :post
   belongs_to :commenter, serializer: Api::V1::PostUserSerializer
end
