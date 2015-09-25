class RemoveAddressFromGatherings < ActiveRecord::Migration
  def change
    remove_column :gatherings, :address
    remove_column :gatherings, :longitude
    remove_column :gatherings, :latitude
  end
end
