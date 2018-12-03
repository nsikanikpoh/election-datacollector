json.extract! donation, :id, :line, :amount, :user_id, :created_at, :updated_at
json.url donation_url(donation, format: :json)
