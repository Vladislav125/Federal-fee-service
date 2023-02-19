json.extract! user, :id, :login, :password_digest, :income, :created_at, :updated_at
json.url user_url(user, format: :json)
