ActiveRecord::Schema.define(version: 20150708163603) do

  enable_extension 'plpgsql'

  create_table 'users', force: :cascade do |t|
    t.string   'username'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
