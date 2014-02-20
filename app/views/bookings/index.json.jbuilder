json.array!(@bookings) do |booking|
  json.extract! booking, :id, :start_date, :end_time, :flat_id, :booker_id
  json.url booking_url(booking, format: :json)
end
