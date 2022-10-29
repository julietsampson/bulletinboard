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

ActiveRecord::Schema.define(version: 20221029174535) do

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.datetime "datetime"
    t.string   "location"
    t.text     "description"
    t.string   "tags",         default: "--- []\n"
    t.integer  "organizer_id"
  end

  add_index "events", ["organizer_id"], name: "index_events_on_organizer_id"

  create_table "events_students", id: false, force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "event_id",   null: false
  end

  add_index "events_students", ["event_id"], name: "index_events_students_on_event_id"
  add_index "events_students", ["student_id"], name: "index_events_students_on_student_id"

  create_table "movies", force: :cascade do |t|
    t.string   "title"
    t.string   "rating"
    t.text     "description"
    t.datetime "release_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
  end

  create_table "students", force: :cascade do |t|
    t.string "uni"
    t.string "name"
    t.string "password"
  end

end
