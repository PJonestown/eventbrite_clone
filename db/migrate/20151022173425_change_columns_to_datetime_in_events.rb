class ChangeColumnsToDatetimeInEvents < ActiveRecord::Migration
  def change
    remove_column :events, :date
    remove_column :events, :time
    add_column :events, :date, :datetime
  end
end
