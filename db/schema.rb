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

ActiveRecord::Schema.define(version: 2021_08_05_004519) do

  create_table "shortened_urls", force: :cascade do |t|
    t.string "short_url", null: false
    t.string "long_url", null: false
    t.integer "submitted_user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "\"user_id\"", name: "index_shortened_urls_on_user_id"
    t.index ["short_url"], name: "index_shortened_urls_on_short_url", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.boolean "premium", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "visits", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "shortend_url_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shortend_url_id"], name: "index_visits_on_shortend_url_id"
    t.index ["user_id"], name: "index_visits_on_user_id"
  end

end
