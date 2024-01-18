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

ActiveRecord::Schema[7.1].define(version: 2024_01_18_230744) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "patient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
  end

  create_table "exercise_entries", force: :cascade do |t|
    t.string "goal"
    t.integer "exercise_type"
    t.integer "total_minutes"
    t.date "date"
    t.bigint "patient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_exercise_entries_on_patient_id"
  end

  create_table "journal_entries", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.date "date"
    t.bigint "patient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_journal_entries_on_patient_id"
  end

  create_table "medication_entries", force: :cascade do |t|
    t.string "name"
    t.string "purpose"
    t.string "dose"
    t.string "schedule"
    t.bigint "patient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_medication_entries_on_patient_id"
  end

  create_table "mindfulness_activities", force: :cascade do |t|
    t.integer "total_minutes"
    t.string "notes"
    t.date "date"
    t.bigint "patient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_mindfulness_activities_on_patient_id"
  end

  create_table "moods", force: :cascade do |t|
    t.integer "current_mood_scale"
    t.integer "stress_level_scale"
    t.string "notes"
    t.date "date"
    t.bigint "patient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_moods_on_patient_id"
  end

  create_table "nutrition_entries", force: :cascade do |t|
    t.string "food_item"
    t.integer "number_of_servings"
    t.boolean "healthy"
    t.integer "cups_of_water"
    t.integer "fruits_and_veg_servings"
    t.boolean "correct_portion"
    t.date "data"
    t.bigint "patient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_nutrition_entries_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.date "dob"
    t.string "phone"
    t.string "address"
    t.string "emergency_contact_name"
    t.string "emergency_contact_number"
    t.bigint "therapist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["therapist_id"], name: "index_patients_on_therapist_id"
  end

  create_table "patterns", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.integer "average_mood"
    t.integer "average_stress_level"
    t.integer "average_stress_before_exercise"
    t.integer "average_stress_after_exercise"
    t.integer "average_mood_with_good_nutrition"
    t.integer "average_mood_with_bad_nutrition"
    t.integer "average_mood_before_journaling"
    t.integer "average_mood_after_journaling"
    t.integer "average_mood_before_mindfulness"
    t.integer "average_mood_after_mindfulness"
    t.integer "average_stress_before_mindfulness"
    t.integer "average_stress_after_mindfulness"
    t.integer "average_mood_before_social_event"
    t.integer "average_mood_after_social_event"
    t.integer "average_mood_before_meds"
    t.integer "average_mood_after_meds"
    t.bigint "patient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_patterns_on_patient_id"
  end

  create_table "sleep_entries", force: :cascade do |t|
    t.integer "quality_rating"
    t.integer "total_hours"
    t.boolean "dream"
    t.string "notes"
    t.date "date"
    t.bigint "patient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_sleep_entries_on_patient_id"
  end

  create_table "social_interactions", force: :cascade do |t|
    t.string "activity_type"
    t.integer "number_of_participants"
    t.integer "enjoyment_scale"
    t.string "location"
    t.integer "duration_in_minutes"
    t.date "date"
    t.bigint "patient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_social_interactions_on_patient_id"
  end

  create_table "therapists", force: :cascade do |t|
    t.string "name"
    t.string "specialization"
    t.string "credentials"
    t.string "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "appointments", "patients"
  add_foreign_key "exercise_entries", "patients"
  add_foreign_key "journal_entries", "patients"
  add_foreign_key "medication_entries", "patients"
  add_foreign_key "mindfulness_activities", "patients"
  add_foreign_key "moods", "patients"
  add_foreign_key "nutrition_entries", "patients"
  add_foreign_key "patients", "therapists"
  add_foreign_key "patterns", "patients"
  add_foreign_key "sleep_entries", "patients"
  add_foreign_key "social_interactions", "patients"
end
