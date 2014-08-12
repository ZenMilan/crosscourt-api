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

ActiveRecord::Schema.define(version: 5) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "organization_affiliations", force: true do |t|
    t.integer "user_id"
    t.integer "organization_id"
  end

  create_table "organizations", force: true do |t|
    t.string   "name",       null: false
    t.string   "org_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.integer  "organization_id"
    t.string   "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "name",            null: false
    t.string   "purpose"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "type",       limit: 50,  null: false
    t.string   "name",                   null: false
    t.string   "email",                  null: false
    t.string   "token",      limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end