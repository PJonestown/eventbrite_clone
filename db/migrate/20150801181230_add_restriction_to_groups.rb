class AddRestrictionToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :restricted, :boolean, default: false
    remove_column :groups, :restriction_type
  end
end
