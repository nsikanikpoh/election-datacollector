class Conversation < ApplicationRecord
  belongs_to :fund_raiser
  belongs_to :pros, polymorphic: true
end
