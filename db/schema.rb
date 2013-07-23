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
ActiveRecord::Schema.define(version: 20130723203341) do

  create_table "admins", force: true do |t|
    t.string   "first_name",             null: false
    t.string   "last_name",              null: false
    t.string   "user_name",              null: false
    t.string   "email",                  null: false
    t.string   "password_digest",        null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "invitation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", force: true do |t|
    t.integer  "sender_id"
    t.string   "recipient_email"
    t.string   "invite_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name",             null: false
    t.string   "last_name",              null: false
    t.string   "user_name",              null: false
    t.string   "email",                  null: false
    t.string   "password_digest",        null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
