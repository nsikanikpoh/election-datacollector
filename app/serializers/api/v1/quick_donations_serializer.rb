class Api::V1::QuickDonationSerializer < ActiveModel::Serializer
   attributes(*QuickDonation.attribute_names.map(&:to_sym))
end