class FixGroupReferenceTypoForEvents < ActiveRecord::Migration
  def change
    remove_reference :events, :groups, index: true
    add_reference :events, :group, index: true
  end
end
