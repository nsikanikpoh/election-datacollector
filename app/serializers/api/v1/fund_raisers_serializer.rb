class Api::V1::FundRaisersSerializer < ActiveModel::Serializer
   attributes(*FundRaiser.attribute_names.map(&:to_sym))
   has_many :prospects
  
end
