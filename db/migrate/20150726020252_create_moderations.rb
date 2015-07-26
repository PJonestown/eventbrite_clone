class CreateModerations < ActiveRecord::Migration
  def change
    create_table :moderations do |t|
      t.integer :moderator_id
      t.integer :moderated_group_id

      t.timestamps null: false
    end
  end
end
