class ChangeGatheringEventToDatetime < ActiveRecord::Migration
  def change
    remove_column :gatherings, :date
    add_column :gatherings, :date, :datetime
  end
end
