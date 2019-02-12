class Api::V1::PollingUnitsSerializer < ActiveModel::Serializer
  attributes(*PollingUnit.attribute_names.map(&:to_sym))
end
