# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_24_003301) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cat_rentals", force: :cascade do |t|
    t.integer "cat_id", null: false
    t.date "start", null: false
    t.date "end", null: false
    t.string "status", null: false
  end

  create_table "cats", force: :cascade do |t|
    t.date "birth_date", null: false
    t.string "color", null: false
    t.string "sex", null: false
    t.string "name", null: false
    t.string "description", null: false
    t.string "owner_id", null: false
    t.index ["owner_id"], name: "index_cats_on_owner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "password_digest", null: false
    t.string "session_token", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
