class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :body
  has_one :fundraiser
end
