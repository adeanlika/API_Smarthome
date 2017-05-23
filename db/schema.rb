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

ActiveRecord::Schema.define(version: 20170523114119) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_smarthomes", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admin_smarthomes_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_smarthomes_on_reset_password_token", unique: true, using: :btree
  end

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
    t.string   "product_id"
    t.binary   "img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "home_id"
    t.index ["home_id"], name: "index_devices_on_home_id", using: :btree
  end

  create_table "energies", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.float    "pwr"
    t.float    "total"
    t.float    "energy_delta"
    t.float    "pfA"
    t.float    "tcA"
    t.float    "cA"
    t.float    "vA"
    t.float    "rpA"
    t.string   "devid"
    t.datetime "updated_at",   null: false
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
    t.datetime "created_at",       null: false
    t.string   "name"
    t.float    "lowertemp"
    t.float    "uppertemp"
    t.float    "lowerhum"
    t.float    "upperhum"
    t.float    "lowerco"
    t.float    "upperco"
    t.float    "lowerflux"
    t.float    "upperflux"
    t.float    "upperenergy"
    t.string   "devid"
    t.string   "gateway_id"
    t.boolean  "lowertemp_flag"
    t.boolean  "uppertemp_flag"
    t.boolean  "lowerhum_flag"
    t.boolean  "upperhum_flag"
    t.boolean  "lowerco_flag"
    t.boolean  "upperco_flag"
    t.boolean  "upperenergy_flag"
    t.boolean  "lowerflux_flag"
    t.boolean  "upperflux_flag"
    t.datetime "updated_at",       null: false
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
    t.integer  "relay1"
    t.integer  "relay2"
    t.integer  "relay3"
    t.integer  "relay4"
    t.integer  "relay5"
    t.integer  "relay6"
    t.integer  "relay7"
    t.integer  "relay8"
    t.string   "relay1name"
    t.string   "relay2name"
    t.string   "relay3name"
    t.string   "relay4name"
    t.string   "relay5name"
    t.string   "relay6name"
    t.string   "relay7name"
    t.string   "relay8name"
    t.string   "ac_enable"
    t.string   "ac_power"
    t.string   "ac_mode"
    t.string   "ac_temp"
    t.string   "ac_speed"
    t.string   "ac_swing"
    t.string   "ac_brand"
    t.string   "ac_state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "device_id"
    t.index ["device_id"], name: "index_relays_on_device_id", using: :btree
  end

  create_table "superusers", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_superusers_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_superusers_on_reset_password_token", unique: true, using: :btree
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
  add_foreign_key "relays", "devices"
end
