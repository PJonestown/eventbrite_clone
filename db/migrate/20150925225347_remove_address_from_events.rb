class RemoveAddressFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :address
    remove_column :events, :longitude
    remove_column :events, :latitude
  end
end
