json.extract! user, :id, :first_name, :last_name, :avarta, :title, :sex, :phone, :type, :address, :info, :category_id, :catlevel1_id, :catlevel2_id, :catlevel3_id, :city, :state, :created_at, :updated_at
json.url user_url(user, format: :json)
