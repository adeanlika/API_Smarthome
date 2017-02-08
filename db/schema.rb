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

ActiveRecord::Schema.define(version: 20170207033326) do

  create_table "alerts", force: :cascade do |t|
    t.string   "sensor_name"
    t.float    "value"
    t.string   "warning"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "home_id"
    t.integer  "device_id"
    t.index ["device_id"], name: "index_alerts_on_device_id"
    t.index ["home_id"], name: "index_alerts_on_home_id"
  end

  create_table "devices", force: :cascade do |t|
    t.string   "name"
    t.string   "productID"
    t.binary   "img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "home_id"
    t.index ["home_id"], name: "index_devices_on_home_id"
  end

  create_table "energies", force: :cascade do |t|
    t.float    "power"
    t.float    "Etotal"
    t.float    "Eday"
    t.float    "Emonth"
    t.float    "Eyear"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "home_id"
    t.index ["home_id"], name: "index_energies_on_home_id"
  end

  create_table "homes", force: :cascade do |t|
    t.string   "name"
    t.string   "sensor"
    t.float    "max"
    t.float    "min"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "homes_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "home_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["home_id"], name: "index_homes_users_on_home_id"
    t.index ["user_id"], name: "index_homes_users_on_user_id"
  end

  create_table "humidities", force: :cascade do |t|
    t.float    "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "device_id"
    t.index ["device_id"], name: "index_humidities_on_device_id"
  end

  create_table "relays", force: :cascade do |t|
    t.binary   "relay1",      limit: 1, default: "x'30'"
    t.binary   "relay2",      limit: 1, default: "x'30'"
    t.binary   "relay3",      limit: 1, default: "x'30'"
    t.binary   "relay4",      limit: 1, default: "x'30'"
    t.binary   "relay5",      limit: 1, default: "x'30'"
    t.binary   "relay6",      limit: 1, default: "x'30'"
    t.binary   "relay7",      limit: 1, default: "x'30'"
    t.binary   "relay8",      limit: 1, default: "x'30'"
    t.string   "relay1name"
    t.string   "relay2name"
    t.string   "relay3name"
    t.string   "relay4name"
    t.string   "relay5name"
    t.string   "relay6name"
    t.string   "relay7name"
    t.string   "relay8name"
    t.string   "acname"
    t.binary   "acmode",      limit: 4, default: "x'30'"
    t.binary   "acstate",     limit: 4, default: "x'30'"
    t.binary   "acspeed",     limit: 4, default: "x'30'"
    t.binary   "acdirection", limit: 4, default: "x'30'"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "device_id"
    t.index ["device_id"], name: "index_relays_on_device_id"
  end

  create_table "temperatures", force: :cascade do |t|
    t.float    "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "device_id"
    t.index ["device_id"], name: "index_temperatures_on_device_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "username"
    t.string   "email"
    t.string   "password"
    t.binary   "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
