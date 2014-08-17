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

ActiveRecord::Schema.define(version: 20140817030545) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "event_id"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "entry_start_date"
    t.datetime "entry_end_date"
    t.datetime "show_date"
    t.datetime "judging_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "sub_heading"
    t.string   "paypal_email_address"
    t.string   "txn_id"
  end

  create_table "orders", force: true do |t|
    t.datetime "payment_date"
    t.string   "email"
    t.string   "verify_sign"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address_city"
    t.string   "address_name"
    t.string   "address_state"
    t.string   "address_street"
    t.string   "address_zip"
    t.string   "payment_gross"
    t.string   "payment_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "submissions", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.integer  "category_id"
    t.string   "user_role"
    t.string   "client"
    t.string   "title"
    t.string   "budget"
    t.string   "production_company"
    t.text     "comments_other"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "video_url"
    t.string   "director"
    t.string   "editor"
    t.string   "producer"
    t.string   "cinematographer"
    t.string   "upload_url"
    t.integer  "order_id"
  end

  create_table "user_types", force: true do |t|
    t.string   "name"
    t.integer  "earlybird_cost"
    t.integer  "standard_cost"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
    t.string   "title"
    t.string   "company"
    t.integer  "user_type_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
