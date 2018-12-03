class Api::V1::PostsSerializer < ActiveModel::Serializer
   attributes(*Post.attribute_names.map(&:to_sym))
   belongs_to :user
end
