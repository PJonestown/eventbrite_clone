json.array!(@addresses) do |address|
  json.extract! address, :id, :location, :latitude, :longitude, :addressable_id, :addressable_type
  json.url address_url(address, format: :json)
end
