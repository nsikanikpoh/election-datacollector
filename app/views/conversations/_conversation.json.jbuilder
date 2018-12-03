json.extract! conversation, :id, :fundraiser_id, :body, :created_at, :updated_at
json.url conversation_url(conversation, format: :json)
