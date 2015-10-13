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

ActiveRecord::Schema.define(version: 20151009053438) do

  create_table "buildings", force: :cascade do |t|
    t.string   "building_name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "classroom_timings", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "rooms_id"
    t.integer  "timeslots_id"
  end

  add_index "classroom_timings", ["rooms_id"], name: "index_classroom_timings_on_rooms_id"
  add_index "classroom_timings", ["timeslots_id"], name: "index_classroom_timings_on_timeslots_id"

  create_table "course_assignments", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "faculties_id"
    t.integer  "courses_id"
    t.integer  "rooms_id"
    t.integer  "daycombinations_id"
    t.integer  "timeslots_id"
  end

  add_index "course_assignments", ["courses_id"], name: "index_course_assignments_on_courses_id"
  add_index "course_assignments", ["daycombinations_id"], name: "index_course_assignments_on_daycombinations_id"
  add_index "course_assignments", ["faculties_id"], name: "index_course_assignments_on_faculties_id"
  add_index "course_assignments", ["rooms_id"], name: "index_course_assignments_on_rooms_id"
  add_index "course_assignments", ["timeslots_id"], name: "index_course_assignments_on_timeslots_id"

  create_table "courses", force: :cascade do |t|
    t.string   "course_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "faculties_id"
    t.integer  "courses_id"
  end

  add_index "courses", ["courses_id"], name: "index_courses_on_courses_id"
  add_index "courses", ["faculties_id"], name: "index_courses_on_faculties_id"

  create_table "day_combinations", force: :cascade do |t|
    t.string   "day_combination"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "faculties", force: :cascade do |t|
    t.string   "faculty_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "faculty_preferences", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "faculties_id"
    t.integer  "preference1_id"
    t.integer  "preference2_id"
    t.integer  "preference3_id"
  end

  add_index "faculty_preferences", ["faculties_id"], name: "index_faculty_preferences_on_faculties_id"
  add_index "faculty_preferences", ["preference1_id"], name: "index_faculty_preferences_on_preference1_id"
  add_index "faculty_preferences", ["preference2_id"], name: "index_faculty_preferences_on_preference2_id"
  add_index "faculty_preferences", ["preference3_id"], name: "index_faculty_preferences_on_preference3_id"

  create_table "faculty_to_courses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "preferences", force: :cascade do |t|
    t.text     "note"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "buildings_id"
    t.integer  "daycombinations_id"
    t.integer  "timeslots_id"
  end

  add_index "preferences", ["buildings_id"], name: "index_preferences_on_buildings_id"
  add_index "preferences", ["daycombinations_id"], name: "index_preferences_on_daycombinations_id"
  add_index "preferences", ["timeslots_id"], name: "index_preferences_on_timeslots_id"

  create_table "rooms", force: :cascade do |t|
    t.string   "room_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "Buildings_id"
  end

  add_index "rooms", ["Buildings_id"], name: "index_rooms_on_Buildings_id"

  create_table "time_slots", force: :cascade do |t|
    t.string   "time_slot"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
