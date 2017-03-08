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

ActiveRecord::Schema.define(version: 20170218080711) do

  create_table "alert_settings", force: :cascade do |t|
    t.integer  "value"
    t.integer  "operation"
    t.integer  "sensor_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "device_id"
    t.index ["device_id"], name: "index_alert_settings_on_device_id"
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

  create_table "energy_alert_logs", force: :cascade do |t|
    t.string   "warning"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "energies_id"
    t.integer  "light_id"
    t.index ["energies_id"], name: "index_energy_alert_logs_on_energies_id"
    t.index ["light_id"], name: "index_energy_alert_logs_on_light_id"
  end

  create_table "homes", force: :cascade do |t|
    t.string   "name"
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

  create_table "hum_alert_logs", force: :cascade do |t|
    t.string   "warning"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "humidity_id"
    t.index ["humidity_id"], name: "index_hum_alert_logs_on_humidity_id"
  end

  create_table "humidities", force: :cascade do |t|
    t.float    "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "device_id"
    t.index ["device_id"], name: "index_humidities_on_device_id"
  end

  create_table "light_alert_logs", force: :cascade do |t|
    t.string   "warning"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "light_id"
    t.index ["light_id"], name: "index_light_alert_logs_on_light_id"
  end

  create_table "lights", force: :cascade do |t|
    t.float    "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "device_id"
    t.index ["device_id"], name: "index_lights_on_device_id"
  end

  create_table "motion_alert_logs", force: :cascade do |t|
    t.string   "warning"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "motion_id"
    t.index ["motion_id"], name: "index_motion_alert_logs_on_motion_id"
  end

  create_table "motions", force: :cascade do |t|
    t.float    "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "device_id"
    t.index ["device_id"], name: "index_motions_on_device_id"
  end

  create_table "relays", force: :cascade do |t|
    t.binary   "relay1",      limit: 1, default: "x'78273738323733333330323727'"
    t.binary   "relay2",      limit: 1, default: "x'78273738323733333330323727'"
    t.binary   "relay3",      limit: 1, default: "x'78273738323733333330323727'"
    t.binary   "relay4",      limit: 1, default: "x'78273738323733333330323727'"
    t.binary   "relay5",      limit: 1, default: "x'78273738323733333330323727'"
    t.binary   "relay6",      limit: 1, default: "x'78273738323733333330323727'"
    t.binary   "relay7",      limit: 1, default: "x'78273738323733333330323727'"
    t.binary   "relay8",      limit: 1, default: "x'78273738323733333330323727'"
    t.string   "relay1name"
    t.string   "relay2name"
    t.string   "relay3name"
    t.string   "relay4name"
    t.string   "relay5name"
    t.string   "relay6name"
    t.string   "relay7name"
    t.string   "relay8name"
    t.string   "acname"
    t.binary   "acmode",      limit: 4, default: "x'78273738323733333330323727'"
    t.binary   "acstate",     limit: 4, default: "x'78273738323733333330323727'"
    t.binary   "acspeed",     limit: 4, default: "x'78273738323733333330323727'"
    t.binary   "acdirection", limit: 4, default: "x'78273738323733333330323727'"
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
    t.integer  "device_id"
    t.index ["device_id"], name: "index_relays_on_device_id"
  end

  create_table "temp_alert_logs", force: :cascade do |t|
    t.string   "warning"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "temperature_id"
    t.index ["temperature_id"], name: "index_temp_alert_logs_on_temperature_id"
  end

  create_table "temperatures", force: :cascade do |t|
    t.float    "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "device_id"
    t.index ["device_id"], name: "index_temperatures_on_device_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.text     "tokens"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

end
