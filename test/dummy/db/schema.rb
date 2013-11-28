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

ActiveRecord::Schema.define(version: 20131128154726) do

  create_table "pushar_apps", force: true do |t|
    t.string   "name",                               null: false
    t.string   "platform",                           null: false
    t.text     "apn_dev_cert"
    t.text     "apn_prod_cert"
    t.text     "apn_app_key"
    t.text     "gcm_api_key"
    t.text     "adm_api_key"
    t.text     "adm_client_id"
    t.text     "adm_client_secret"
    t.integer  "devices_count",          default: 0
    t.integer  "inactive_devices_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pushar_apps", ["platform"], name: "index_pushar_apps_on_platform"

  create_table "pushar_devices", force: true do |t|
    t.integer  "user_id"
    t.string   "token",          null: false
    t.integer  "app_id",         null: false
    t.string   "locale"
    t.datetime "inactivated_at"
    t.boolean  "banner"
    t.boolean  "badge"
    t.boolean  "sound"
    t.string   "app_name"
    t.string   "app_version"
    t.string   "os_name"
    t.string   "os_version"
    t.string   "device_name"
    t.string   "device_version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pushar_devices", ["app_id"], name: "index_pushar_devices_on_app_id"
  add_index "pushar_devices", ["user_id"], name: "index_pushar_devices_on_user_id"

end
