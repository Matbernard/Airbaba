class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.date :start_date
      t.date :end_time
      t.integer :flat_id
      t.integer :booker_id

      t.timestamps
    end
  end
end
