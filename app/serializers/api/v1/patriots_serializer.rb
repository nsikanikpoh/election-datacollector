class Api::V1::PatriotsSerializer < ActiveModel::Serializer
   attributes(*Patriot.attribute_names.map(&:to_sym))
   belongs_to :interest_line, foreign_key: :interest_line_id
    has_many :donations, as: :donator, foreign_key: :donator_id
end
