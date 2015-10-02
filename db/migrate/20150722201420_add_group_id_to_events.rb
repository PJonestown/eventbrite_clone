class AddGroupIdToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :group, index: true
  end
end
