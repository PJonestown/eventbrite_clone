class AddCreatorRefToGathering < ActiveRecord::Migration
  def change
    add_reference :gatherings, :creator, index: true
  end
end
