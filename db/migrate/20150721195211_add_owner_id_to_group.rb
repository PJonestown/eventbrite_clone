class AddOwnerIdToGroup < ActiveRecord::Migration
  def change
    add_reference :groups, :owner, index: true
  end
end
