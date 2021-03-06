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

ActiveRecord::Schema.define(version: 20141213103918) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.integer  "issue_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["issue_id"], name: "index_comments_on_issue_id", using: :btree

  create_table "issues", force: true do |t|
    t.integer  "user_id"
    t.text     "text"
    t.integer  "target_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "opener_id"
    t.integer  "receiver_id"
  end

  add_index "issues", ["opener_id"], name: "index_issues_on_opener_id", using: :btree
  add_index "issues", ["receiver_id"], name: "index_issues_on_receiver_id", using: :btree
  add_index "issues", ["target_user_id"], name: "index_issues_on_target_user_id", using: :btree
  add_index "issues", ["user_id"], name: "index_issues_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "identification_type"
    t.string   "identification_number"
    t.boolean  "extra_plates"
    t.string   "plate"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

end
