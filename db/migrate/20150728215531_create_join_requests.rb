class CreateJoinRequests < ActiveRecord::Migration
  def change
    create_table :join_requests do |t|
      t.references :user, index: true, foreign_key: true
      t.text :message

      t.timestamps null: false
    end
  end
end
