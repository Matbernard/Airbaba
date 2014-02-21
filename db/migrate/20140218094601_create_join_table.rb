class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :tags, :flats do |t|
      t.index [:tag_id, :flat_id]
      t.index [:flat_id, :tag_id]
    end
  end
end
