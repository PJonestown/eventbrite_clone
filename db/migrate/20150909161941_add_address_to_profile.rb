class AddAddressToProfile < ActiveRecord::Migration
  def change
    rename_column :profiles, :zipcode, :location
    add_column :profiles, :longitude, :float
    add_column :profiles, :latitude, :float
  end
end
