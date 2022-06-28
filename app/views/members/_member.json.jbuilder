json.extract! member, :id, :last_name, :first_name, :email, :password, :created_at, :updated_at
json.url member_url(member, format: :json)
