class AddApprovedBooleanToGatherings < ActiveRecord::Migration
  def change
    add_column :gatherings, :approved, :boolean, default: true
  end
end
