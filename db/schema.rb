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

ActiveRecord::Schema.define(version: 20161005205134) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.integer  "connection_id"
    t.integer  "pax"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["connection_id"], name: "index_bookings_on_connection_id", using: :btree
  end

  create_table "connections", force: :cascade do |t|
    t.integer  "departure_stop_id"
    t.integer  "arrival_stop_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "providers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rides", force: :cascade do |t|
    t.integer  "provider_id"
    t.integer  "capacity",    default: 50
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["provider_id"], name: "index_rides_on_provider_id", using: :btree
  end

  create_table "stops", force: :cascade do |t|
    t.integer  "ride_id"
    t.integer  "order"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ride_id"], name: "index_stops_on_ride_id", using: :btree
  end

  add_foreign_key "bookings", "connections"
  add_foreign_key "rides", "providers"
  add_foreign_key "stops", "rides"
end
