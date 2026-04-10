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

ActiveRecord::Schema[8.1].define(version: 2026_04_10_100915) do
  create_table "buffer_entries", force: :cascade do |t|
    t.float "amount"
    t.string "category"
    t.datetime "created_at", null: false
    t.date "date"
    t.text "description"
    t.string "name"
    t.string "transaction_type"
    t.datetime "updated_at", null: false
  end

  create_table "flatmates", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.integer "room_id", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_flatmates_on_room_id"
  end

  create_table "monthly_checks", force: :cascade do |t|
    t.float "account_state"
    t.datetime "created_at", null: false
    t.date "month"
    t.float "transactions_sum"
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.float "due"
    t.string "name"
    t.float "paid"
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.float "amount"
    t.string "category"
    t.datetime "created_at", null: false
    t.date "date"
    t.text "description"
    t.string "flatmate"
    t.string "name"
    t.integer "room_id"
    t.string "transaction_type"
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_transactions_on_room_id"
  end

  add_foreign_key "flatmates", "rooms"
  add_foreign_key "transactions", "rooms"
end
