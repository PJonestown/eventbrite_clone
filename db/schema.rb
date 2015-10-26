# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151022173425) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "cube"
  enable_extension "earthdistance"

  create_table "addresses", force: :cascade do |t|
    t.string   "location"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "attendances", force: :cascade do |t|
    t.integer  "attendee_id"
    t.integer  "attended_event_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "attendable_id"
    t.string   "attendable_type"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "creator_id"
    t.datetime "date"
  end

  add_index "events", ["creator_id"], name: "index_events_on_creator_id", using: :btree

  create_table "gathering_attendances", force: :cascade do |t|
    t.integer  "attendee_id"
    t.integer  "attended_gathering_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "gatherings", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.date     "date"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "creator_id"
    t.integer  "group_id"
    t.boolean  "approved",    default: true
  end

  add_index "gatherings", ["creator_id"], name: "index_gatherings_on_creator_id", using: :btree
  add_index "gatherings", ["group_id"], name: "index_gatherings_on_group_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "owner_id"
    t.text     "description"
    t.integer  "category_id"
    t.boolean  "is_private",  default: false
    t.boolean  "restricted",  default: false
  end

  add_index "groups", ["category_id"], name: "index_groups_on_category_id", using: :btree
  add_index "groups", ["owner_id"], name: "index_groups_on_owner_id", using: :btree

  create_table "join_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "group_id"
  end

  add_index "join_requests", ["group_id"], name: "index_join_requests_on_group_id", using: :btree
  add_index "join_requests", ["user_id"], name: "index_join_requests_on_user_id", using: :btree

  create_table "memberships", force: :cascade do |t|
    t.integer  "member_id"
    t.integer  "group_membership_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "moderations", force: :cascade do |t|
    t.integer  "moderator_id"
    t.integer  "moderated_group_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "join_requests", "users"
end
