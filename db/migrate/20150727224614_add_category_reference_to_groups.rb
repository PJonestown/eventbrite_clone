class AddCategoryReferenceToGroups < ActiveRecord::Migration
  def change
    add_reference :groups, :category, index: true
  end
end
