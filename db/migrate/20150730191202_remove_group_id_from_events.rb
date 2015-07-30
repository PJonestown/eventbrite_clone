class RemoveGroupIdFromEvents < ActiveRecord::Migration
  def change
    remove_index :events, :group_id
    remove_column :events, :group_id
  end
end
