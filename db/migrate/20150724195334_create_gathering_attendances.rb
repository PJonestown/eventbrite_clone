class CreateGatheringAttendances < ActiveRecord::Migration
  def change
    create_table :gathering_attendances do |t|
      t.integer :attendee_id
      t.integer :attended_gathering_id

      t.timestamps null: false
    end
  end
end
