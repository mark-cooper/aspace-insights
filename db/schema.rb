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

ActiveRecord::Schema.define(version: 2021_11_20_105224) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "instances", force: :cascade do |t|
    t.string "code", null: false
    t.string "frontend_url"
    t.string "name"
    t.string "public_url"
    t.string "tier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reports", force: :cascade do |t|
    t.string "checksum", null: false
    t.jsonb "data", null: false
    t.integer "day", null: false
    t.integer "month", null: false
    t.integer "year", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reportable_type"
    t.bigint "reportable_id"
    t.index ["checksum", "day", "month", "year", "reportable_id", "reportable_type"], name: "index_reports_on_checksum_and_date_and_reportable", unique: true
    t.index ["day"], name: "index_reports_on_day"
    t.index ["month"], name: "index_reports_on_month"
    t.index ["reportable_type", "reportable_id"], name: "index_reports_on_reportable_type_and_reportable_id"
    t.index ["year"], name: "index_reports_on_year"
  end

  create_table "repositories", force: :cascade do |t|
    t.string "code", null: false
    t.bigint "instance_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instance_id"], name: "index_repositories_on_instance_id"
  end

  add_foreign_key "repositories", "instances"
end
