class QuickDonationSerializer < ActiveModel::Serializer
  attributes :id, :tel, :email, :amount
end
