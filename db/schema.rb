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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111208222925) do

  create_table "ideas", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "isactive"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ideas", ["user_id"], :name => "index_ideas_on_user_id"

  create_table "responses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "responseid"
    t.string   "voice"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "responses", ["responseid"], :name => "index_responses_on_responseid"
  add_index "responses", ["user_id"], :name => "index_responses_on_user_id"

  create_table "topics", :force => true do |t|
    t.string   "title"
    t.integer  "isactive"
    t.string   "cbuser"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["cbuser"], :name => "index_topics_on_cbuser"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
