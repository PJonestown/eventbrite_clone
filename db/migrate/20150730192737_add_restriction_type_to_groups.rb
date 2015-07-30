class AddRestrictionTypeToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :restriction_type, :integer
  end
end
