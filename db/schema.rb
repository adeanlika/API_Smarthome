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

ActiveRecord::Schema.define(version: 20170424092756) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alert_logs", force: :cascade do |t|
    t.string   "sensor_name"
    t.float    "value"
    t.string   "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "device_id"
    t.index ["device_id"], name: "index_alert_logs_on_device_id", using: :btree
  end

  create_table "carbondioxides", force: :cascade do |t|
    t.float    "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "device_id"
    t.index ["device_id"], name: "index_carbondioxides_on_device_id", using: :btree
  end

  create_table "devices", force: :cascade do |t|
    t.string   "name"
    t.string   "productID"
    t.binary   "img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "home_id"
    t.index ["home_id"], name: "index_devices_on_home_id", using: :btree
  end

  create_table "energies", force: :cascade do |t|
    t.float    "pwr"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.float    "total"
    t.float    "energy_delta"
    t.float    "pfA"
    t.float    "tcA"
    t.float    "cA"
    t.float    "vA"
    t.float    "rpA"
    t.string   "devid"
    t.integer  "home_id"
    t.index ["home_id"], name: "index_energies_on_home_id", using: :btree
  end

  create_table "energy_alert_logs", force: :cascade do |t|
    t.string   "home_name"
    t.float    "value"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "home_id"
    t.index ["home_id"], name: "index_energy_alert_logs_on_home_id", using: :btree
  end

  create_table "homes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.float    "lowertemp"
    t.float    "uppertemp"
    t.float    "lowerhum"
    t.float    "upperhum"
    t.float    "lowerco"
    t.float    "upperco"
    t.float    "lowerflux"
    t.float    "upperflux"
    t.float    "lowerenergy"
    t.float    "upperenergy"
    t.string   "devid"
  end

  create_table "homes_users", force: :cascade do |t|
    t.integer  "home_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["home_id"], name: "index_homes_users_on_home_id", using: :btree
    t.index ["user_id"], name: "index_homes_users_on_user_id", using: :btree
  end

  create_table "humidities", force: :cascade do |t|
    t.float    "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "device_id"
    t.index ["device_id"], name: "index_humidities_on_device_id", using: :btree
  end

  create_table "lights", force: :cascade do |t|
    t.float    "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "device_id"
    t.index ["device_id"], name: "index_lights_on_device_id", using: :btree
  end

  create_table "motions", force: :cascade do |t|
    t.float    "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "device_id"
    t.index ["device_id"], name: "index_motions_on_device_id", using: :btree
  end

  create_table "relays", force: :cascade do |t|
    t.binary   "relay1",      default: "x'7827373832373337333833323337333333373333333833333332333333373333333333333337333333333333333833333333333333323333333333333337333333333333333333333333333333333333333333333333333333333333333033333333333333323333333333333337333333323333333733323337323727'"
    t.binary   "relay2",      default: "x'7827373832373337333833323337333333373333333833333332333333373333333333333337333333333333333833333333333333323333333333333337333333333333333333333333333333333333333333333333333333333333333033333333333333323333333333333337333333323333333733323337323727'"
    t.binary   "relay3",      default: "x'7827373832373337333833323337333333373333333833333332333333373333333333333337333333333333333833333333333333323333333333333337333333333333333333333333333333333333333333333333333333333333333033333333333333323333333333333337333333323333333733323337323727'"
    t.binary   "relay4",      default: "x'7827373832373337333833323337333333373333333833333332333333373333333333333337333333333333333833333333333333323333333333333337333333333333333333333333333333333333333333333333333333333333333033333333333333323333333333333337333333323333333733323337323727'"
    t.binary   "relay5",      default: "x'7827373832373337333833323337333333373333333833333332333333373333333333333337333333333333333833333333333333323333333333333337333333333333333333333333333333333333333333333333333333333333333033333333333333323333333333333337333333323333333733323337323727'"
    t.binary   "relay6",      default: "x'7827373832373337333833323337333333373333333833333332333333373333333333333337333333333333333833333333333333323333333333333337333333333333333333333333333333333333333333333333333333333333333033333333333333323333333333333337333333323333333733323337323727'"
    t.binary   "relay7",      default: "x'7827373832373337333833323337333333373333333833333332333333373333333333333337333333333333333833333333333333323333333333333337333333333333333333333333333333333333333333333333333333333333333033333333333333323333333333333337333333323333333733323337323727'"
    t.binary   "relay8",      default: "x'7827373832373337333833323337333333373333333833333332333333373333333333333337333333333333333833333333333333323333333333333337333333333333333333333333333333333333333333333333333333333333333033333333333333323333333333333337333333323333333733323337323727'"
    t.string   "relay1name"
    t.string   "relay2name"
    t.string   "relay3name"
    t.string   "relay4name"
    t.string   "relay5name"
    t.string   "relay6name"
    t.string   "relay7name"
    t.string   "relay8name"
    t.string   "acname"
    t.binary   "acmode",      default: "x'7827373832373337333833323337333333373333333833333332333333373333333333333337333333333333333833333333333333323333333333333337333333333333333333333333333333333333333333333333333333333333333033333333333333323333333333333337333333323333333733323337323727'"
    t.binary   "acstate",     default: "x'7827373832373337333833323337333333373333333833333332333333373333333333333337333333333333333833333333333333323333333333333337333333333333333333333333333333333333333333333333333333333333333033333333333333323333333333333337333333323333333733323337323727'"
    t.binary   "acspeed",     default: "x'7827373832373337333833323337333333373333333833333332333333373333333333333337333333333333333833333333333333323333333333333337333333333333333333333333333333333333333333333333333333333333333033333333333333323333333333333337333333323333333733323337323727'"
    t.binary   "acdirection", default: "x'7827373832373337333833323337333333373333333833333332333333373333333333333337333333333333333833333333333333323333333333333337333333333333333333333333333333333333333333333333333333333333333033333333333333323333333333333337333333323333333733323337323727'"
    t.datetime "created_at",                                                                                                                                                                                                                                                                            null: false
    t.datetime "updated_at",                                                                                                                                                                                                                                                                            null: false
    t.integer  "device_id"
    t.index ["device_id"], name: "index_relays_on_device_id", using: :btree
  end

  create_table "temperatures", force: :cascade do |t|
    t.float    "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "device_id"
    t.index ["device_id"], name: "index_temperatures_on_device_id", using: :btree
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
    t.string   "token"
    t.string   "fcm_token"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
  end

  add_foreign_key "alert_logs", "devices"
  add_foreign_key "carbondioxides", "devices"
  add_foreign_key "energies", "homes"
  add_foreign_key "energy_alert_logs", "homes"
  add_foreign_key "homes_users", "users"
  add_foreign_key "lights", "devices"
end
