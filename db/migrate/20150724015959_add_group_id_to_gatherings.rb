class AddGroupIdToGatherings < ActiveRecord::Migration
  def change
    add_reference :gatherings, :group, index: true
  end
end
