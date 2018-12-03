class Api::V1::ConversationsSerializer < ActiveModel::Serializer
   attributes :id, :body
   belongs_to :fund_raiser
   belongs_to :pros, serializer: Api::V1::UserSerializer
end
