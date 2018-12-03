class Api::V1::SponsorshipsSerializer < ActiveModel::Serializer
   attributes(*Sponsorship.attribute_names.map(&:to_sym))
end