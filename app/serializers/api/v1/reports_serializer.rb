class Api::V1::ReportsSerializer < ActiveModel::Serializer
   attributes(*Report.attribute_names.map(&:to_sym))
end