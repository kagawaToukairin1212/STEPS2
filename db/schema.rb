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

ActiveRecord::Schema[7.2].define(version: 2024_12_12_111549) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "evaluation_departments", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "default", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "evaluation_scores", force: :cascade do |t|
    t.bigint "goal_id", null: false
    t.integer "result", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["goal_id"], name: "index_evaluation_scores_on_goal_id"
  end

  create_table "goals", force: :cascade do |t|
    t.bigint "sheet_id", null: false
    t.bigint "evaluation_department_id", null: false
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["evaluation_department_id"], name: "index_goals_on_evaluation_department_id"
    t.index ["sheet_id"], name: "index_goals_on_sheet_id"
  end

  create_table "sheets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sheets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "evaluation_scores", "goals"
  add_foreign_key "goals", "evaluation_departments"
  add_foreign_key "goals", "sheets"
  add_foreign_key "sheets", "users"
end
