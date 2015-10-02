class RenamePrivateColumn < ActiveRecord::Migration
  def change
    rename_column :groups, :private, :is_private
  end
end
