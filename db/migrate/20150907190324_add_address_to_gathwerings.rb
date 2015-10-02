class AddAddressToGathwerings < ActiveRecord::Migration
  def change
    add_column :gatherings, :address, :string
    add_column :gatherings, :latitude, :float
    add_column :gatherings, :longitude, :float
  end
end
