class Api::V1::PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :file
   belongs_to :user
   has_many :comments, serializer: Api::V1::CommentsSerializer
end