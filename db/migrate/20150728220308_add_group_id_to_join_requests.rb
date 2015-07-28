class AddGroupIdToJoinRequests < ActiveRecord::Migration
  def change
    add_reference :join_requests, :group, index: true
  end
end
