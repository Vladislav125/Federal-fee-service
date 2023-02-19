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

ActiveRecord::Schema[7.0].define(version: 2022_12_25_003810) do
  create_table "realties", force: :cascade do |t|
    t.string "address", null: false
    t.integer "square", null: false
    t.integer "cost", null: false
    t.integer "realty_tax"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address"], name: "index_realties_on_address", unique: true
    t.index ["user_id"], name: "index_realties_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name", null: false
    t.string "login", null: false
    t.string "password_digest", null: false
    t.string "position", null: false
    t.integer "inn"
    t.integer "income", default: 0
    t.integer "tax", default: 0
    t.integer "tax_payed", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["login"], name: "index_users_on_login", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "license_plate", null: false
    t.string "model", null: false
    t.integer "power", null: false
    t.integer "vehicle_tax"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["license_plate"], name: "index_vehicles_on_license_plate", unique: true
    t.index ["user_id"], name: "index_vehicles_on_user_id"
  end

end
