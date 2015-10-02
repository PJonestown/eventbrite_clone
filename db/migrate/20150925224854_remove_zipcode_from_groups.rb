class RemoveZipcodeFromGroups < ActiveRecord::Migration
  def change
    remove_column :groups, :zipcode
  end
end
