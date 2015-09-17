class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :location
      t.float :latitude
      t.float :longitude
      t.integer :addressable_id
      t.string :addressable_type

      t.timestamps null: false
    end
  end
end
