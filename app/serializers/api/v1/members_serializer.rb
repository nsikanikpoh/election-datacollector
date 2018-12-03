class Api::V1::MembersSerializer < ActiveModel::Serializer
   attributes(*Member.attribute_names.map(&:to_sym))
end
