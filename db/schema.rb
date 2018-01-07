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

ActiveRecord::Schema.define(version: 20180107162459) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "histories", force: :cascade do |t|
    t.jsonb "object_changes"
    t.string "historyable_type"
    t.bigint "historyable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["historyable_type", "historyable_id"], name: "index_histories_on_historyable_type_and_historyable_id"
    t.index ["object_changes"], name: "index_histories_on_object_changes", using: :gin
  end

  create_table "invoices", force: :cascade do |t|
    t.bigint "order_id"
    t.string "status"
    t.integer "total"
    t.text "product_ids", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_invoices_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "customer_name"
    t.string "customer_address"
    t.string "status"
    t.date "ship_date"
    t.string "shipping_provider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.integer "stock_levels"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "invoices", "orders"
end
