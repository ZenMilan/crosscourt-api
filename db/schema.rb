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

ActiveRecord::Schema.define(version: 9) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_tokens", force: true do |t|
    t.string   "token",                      null: false
    t.string   "description"
    t.boolean  "available",   default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "access_tokens", ["token"], name: "index_access_tokens_on_token", unique: true, using: :btree

  create_table "affiliations", force: true do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "features", force: true do |t|
    t.integer  "project_id",                            null: false
    t.string   "title"
    t.text     "description"
    t.decimal  "price",         precision: 8, scale: 2
    t.string   "delivery_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", force: true do |t|
    t.string   "type"
    t.integer  "sender_id"
    t.string   "recipient_email"
    t.integer  "organization_id"
    t.integer  "project_id"
    t.string   "token"
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invitations", ["token"], name: "index_invitations_on_token", unique: true, using: :btree

  create_table "organizations", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.integer  "organization_id"
    t.integer  "user_id"
    t.string   "payment_details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["organization_id"], name: "index_payments_on_organization_id", unique: true, using: :btree

  create_table "projects", force: true do |t|
    t.string   "name",            null: false
    t.integer  "organization_id", null: false
    t.string   "purpose"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proposals", force: true do |t|
    t.boolean  "approved",   default: false
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "type",            limit: 50, null: false
    t.string   "name",                       null: false
    t.string   "email",                      null: false
    t.string   "password_digest"
    t.integer  "invitation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
