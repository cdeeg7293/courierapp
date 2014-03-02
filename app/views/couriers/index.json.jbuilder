json.array!(@couriers) do |courier|
  json.extract! courier, :id, :client_id, :address_id
  json.url courier_url(courier, format: :json)
end
