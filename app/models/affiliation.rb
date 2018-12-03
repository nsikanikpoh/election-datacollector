class Affiliation < ApplicationRecord
  belongs_to :affiliate, :class_name => "User", :foreign_key => "affiliate_id"
  belongs_to :referred, :class_name => "User", :foreign_key => "referred_id"
end
