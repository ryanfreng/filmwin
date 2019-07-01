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

ActiveRecord::Schema.define(version: 20190701011201) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description"
    t.integer  "event_id"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: :cascade do |t|
    t.string   "name",                 limit: 255
    t.text     "description"
    t.datetime "entry_start_date"
    t.datetime "entry_end_date"
    t.datetime "show_date"
    t.datetime "judging_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "sub_heading",          limit: 255
    t.string   "paypal_email_address", limit: 255
    t.datetime "earlybird_date"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "payment_date"
    t.string   "email",          limit: 255
    t.string   "verify_sign",    limit: 255
    t.string   "first_name",     limit: 255
    t.string   "last_name",      limit: 255
    t.string   "address_city",   limit: 255
    t.string   "address_name",   limit: 255
    t.string   "address_state",  limit: 255
    t.string   "address_street", limit: 255
    t.string   "address_zip",    limit: 255
    t.string   "payment_gross",  limit: 255
    t.string   "payment_status", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "txn_id",         limit: 255
  end

  create_table "submission_costs", force: :cascade do |t|
    t.integer  "standard"
    t.integer  "earlybird"
    t.integer  "submission_quantity_id"
    t.integer  "user_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "submission_costs", ["submission_quantity_id"], name: "index_submission_costs_on_submission_quantity_id", using: :btree
  add_index "submission_costs", ["user_type_id"], name: "index_submission_costs_on_user_type_id", using: :btree

  create_table "submission_quantities", force: :cascade do |t|
    t.integer  "beginning_value"
    t.integer  "end_value"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "submission_quantities", ["event_id"], name: "index_submission_quantities_on_event_id", using: :btree

  create_table "submissions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.integer  "category_id"
    t.string   "user_role",          limit: 255
    t.string   "client",             limit: 255
    t.string   "title",              limit: 255
    t.string   "budget",             limit: 255
    t.string   "production_company", limit: 255
    t.text     "comments_other"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "video_url",          limit: 255
    t.string   "director",           limit: 255
    t.string   "editor",             limit: 255
    t.string   "producer",           limit: 255
    t.string   "cinematographer",    limit: 255
    t.string   "upload_url",         limit: 255
    t.integer  "order_id"
    t.string   "contact_name",       limit: 255
    t.string   "recipient_name",     limit: 255
    t.text     "extra_crew"
    t.text     "contact_phone"
    t.text     "contact_email"
    t.text     "animator"
    t.text     "writer"
    t.text     "sound_designer"
    t.text     "running_time"
  end

  create_table "user_types", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "earlybird_cost"
    t.integer  "standard_cost"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "email",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest", limit: 255
    t.string   "remember_token",  limit: 255
    t.boolean  "admin",                       default: false
    t.string   "title",           limit: 255
    t.string   "company",         limit: 255
    t.integer  "user_type_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
