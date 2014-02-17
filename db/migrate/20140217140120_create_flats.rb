class CreateFlats < ActiveRecord::Migration
  def change
    create_table :flats do |t|
      t.string :title
      t.string :address
      t.integer :day_price
      t.text :description
      t.integer :owner_id

      t.timestamps
    end
  end
end
