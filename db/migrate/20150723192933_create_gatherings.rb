class CreateGatherings < ActiveRecord::Migration
  def change
    create_table :gatherings do |t|
      t.string :name
      t.string :description
      t.date :date

      t.timestamps null: false
    end
  end
end
