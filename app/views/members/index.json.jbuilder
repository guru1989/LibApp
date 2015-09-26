json.array!(@members) do |member|
  json.extract! member, :id, :name, :email, :password
  json.url member_url(member, format: :json)
end
