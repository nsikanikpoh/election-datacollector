class Api::V1::CollagesSerializer < ActiveModel::Serializer
  attributes :id, :title
   has_many :pics, serializer: Api::V1::PicsSerializer, inverse_of: :collage
end