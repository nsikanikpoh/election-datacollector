class Api::V1::ProspectsSerializer < ActiveModel::Serializer
   attributes(*Prospect.attribute_names.map(&:to_sym))
   belongs_to :fund_raiser, serializer: Api::V1::FundRaisersSerializer
end
