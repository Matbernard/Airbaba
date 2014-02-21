json.array!(@flats) do |flat|
  json.extract! flat, :id, :title, :address, :day_price, :description, :owner_id
  json.url flat_url(flat, format: :json)
end
