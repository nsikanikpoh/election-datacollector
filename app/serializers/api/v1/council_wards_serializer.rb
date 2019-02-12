class Api::V1::CouncilWardsSerializer < ActiveModel::Serializer
   attributes(*CouncilWard.attribute_names.map(&:to_sym))
end