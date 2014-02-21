class CreateFlats < ActiveRecord::Migration
  def change
    create_table :flats do |t|
      t.string :title
      t.string :address
      t.integer :day_price
      t.text :description
      t.belongs_to :owner

      t.timestamps
    end
  end
end
