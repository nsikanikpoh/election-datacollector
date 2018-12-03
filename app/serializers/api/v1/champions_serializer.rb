class Api::V1::ChampionsSerializer < ActiveModel::Serializer
   attributes(*Champion.attribute_names.map(&:to_sym))
   has_many :posts
end
