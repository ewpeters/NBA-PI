# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101209051323) do

  create_table "followings", :force => true do |t|
    t.integer  "woman_id"
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", :force => true do |t|
    t.integer  "twitter_id"
    t.string   "name"
    t.string   "twitter_name"
    t.integer  "team_id"
    t.boolean  "processed",       :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "total_followers"
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votables", :force => true do |t|
    t.string   "twitter_name"
    t.string   "twitter_id"
    t.integer  "yay"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "women", :force => true do |t|
    t.integer  "twitter_id"
    t.string   "name"
    t.string   "twitter_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
