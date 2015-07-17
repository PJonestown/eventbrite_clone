class RenameEventAttendeesToAttendence < ActiveRecord::Migration
  def change
    rename_table :event_attendees, :attendances
  end
end
