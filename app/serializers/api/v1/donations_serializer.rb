class Api::V1::DonationsSerializer < ActiveModel::Serializer
   attributes(*Donation.attribute_names.map(&:to_sym))
end