class Api::V1::InterestLineSerializer < ActiveModel::Serializer
  attributes(*InterestLine.attribute_names.map(&:to_sym))
end
