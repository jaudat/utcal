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

ActiveRecord::Schema.define(:version => 20130428193256) do

  create_table "assignments", :force => true do |t|
    t.string   "title"
    t.string   "category"
    t.text     "description"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "day"
  end

  create_table "assignments_courses", :id => false, :force => true do |t|
    t.integer "course_id"
    t.integer "assignment_id"
  end

  create_table "courses", :force => true do |t|
    t.string   "code"
    t.string   "section"
    t.string   "restrictions"
    t.string   "days"
    t.datetime "start"
    t.datetime "end"
    t.string   "location"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "meeting"
  end

  create_table "courses_users", :id => false, :force => true do |t|
    t.integer "course_id"
    t.integer "user_id"
  end

  add_index "courses_users", ["course_id"], :name => "course_id"
  add_index "courses_users", ["user_id"], :name => "user_id"

  create_table "professors", :force => true do |t|
    t.string   "f_name"
    t.string   "l_name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "students", :force => true do |t|
    t.integer  "stud_no"
    t.string   "f_name"
    t.string   "l_name"
    t.text     "address"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "utorid"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "category"
  end

end
