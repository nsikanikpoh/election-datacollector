json.extract! quick_donation, :id, :tel, :email, :amount, :created_at, :updated_at
json.url quick_donation_url(quick_donation, format: :json)
