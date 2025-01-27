# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_11_12_012033) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.text "name"
    t.datetime "datetime"
    t.text "location"
    t.text "description"
    t.text "tags", default: [], array: true
    t.bigint "organizer_id"
    t.index ["organizer_id"], name: "index_events_on_organizer_id"
  end

  create_table "events_students", id: false, force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "event_id", null: false
    t.index ["event_id"], name: "index_events_students_on_event_id"
    t.index ["student_id"], name: "index_events_students_on_student_id"
  end

  create_table "organizers", force: :cascade do |t|
    t.text "name"
    t.text "email", null: false
    t.text "password", null: false
    t.index ["email"], name: "index_organizers_on_email", unique: true
  end

  create_table "students", force: :cascade do |t|
    t.text "uni", null: false
    t.text "name"
    t.text "password", null: false
    t.text "tags", default: [], array: true
    t.index ["uni"], name: "index_students_on_uni", unique: true
  end

  create_table "timeblocks", force: :cascade do |t|
    t.tsrange "busy_range"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "student_id"
    t.index ["student_id"], name: "index_timeblocks_on_student_id"
  end

  add_foreign_key "events", "organizers"
  add_foreign_key "timeblocks", "students"
end
