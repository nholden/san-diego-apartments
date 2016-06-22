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

ActiveRecord::Schema.define(version: 20160622085148) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "available_alerts", force: :cascade do |t|
    t.date     "old_value"
    t.date     "new_value"
    t.integer  "unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "available_alerts", ["unit_id"], name: "index_available_alerts_on_unit_id", using: :btree

  create_table "buildings", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "listings", force: :cascade do |t|
    t.integer  "rent"
    t.integer  "lease_months"
    t.date     "available"
    t.integer  "unit_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "listings", ["unit_id"], name: "index_listings_on_unit_id", using: :btree

  create_table "new_unit_alerts", force: :cascade do |t|
    t.integer  "unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "new_unit_alerts", ["unit_id"], name: "index_new_unit_alerts_on_unit_id", using: :btree

  create_table "recipients", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rent_alerts", force: :cascade do |t|
    t.integer  "old_value"
    t.integer  "new_value"
    t.integer  "unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "rent_alerts", ["unit_id"], name: "index_rent_alerts_on_unit_id", using: :btree

  create_table "scraped_listings", force: :cascade do |t|
    t.string   "unit_name"
    t.integer  "rent"
    t.date     "available"
    t.integer  "beds"
    t.integer  "square_feet"
    t.integer  "lease_months"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "building_name"
    t.string   "address"
    t.string   "website"
  end

  create_table "units", force: :cascade do |t|
    t.string   "name"
    t.integer  "beds"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "building_id"
    t.integer  "square_feet"
    t.integer  "rent"
    t.date     "available"
    t.integer  "lease_months"
    t.datetime "last_seen"
  end

  add_index "units", ["building_id"], name: "index_units_on_building_id", using: :btree

end
