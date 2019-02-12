class Api::V1::UsersSerializer < ActiveModel::Serializer
   attributes(*User.attribute_names.map(&:to_sym))
 
end
