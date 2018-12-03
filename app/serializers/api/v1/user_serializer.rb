class Api::V1::UserSerializer < ActiveModel::Serializer
   attributes(*User.attribute_names.map(&:to_sym))
end