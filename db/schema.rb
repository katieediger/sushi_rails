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

ActiveRecord::Schema.define(version: 20180316192851) do

  create_table "data", force: :cascade do |t|
    t.string "date"
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "organization_id"
    t.integer "sushi_id"
    t.index ["organization_id"], name: "index_data_on_organization_id"
    t.index ["sushi_id"], name: "index_data_on_sushi_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sushis", force: :cascade do |t|
    t.string "name"
    t.string "endpoint"
    t.string "cust_id"
    t.string "req_id"
    t.string "report_start"
    t.string "report_end"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "organization_id"
    t.index ["organization_id"], name: "index_sushis_on_organization_id"
    t.index ["user_id"], name: "index_sushis_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "organization"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "location"
    t.string "image_url"
    t.integer "organization_id"
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
    t.index ["provider"], name: "index_users_on_provider"
    t.index ["uid"], name: "index_users_on_uid"
  end

  create_table "validsushis", force: :cascade do |t|
    t.string "name"
    t.string "endpoint"
    t.string "cust_id"
    t.string "req_id"
    t.string "report_start"
    t.string "report_end"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
