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

ActiveRecord::Schema.define(version: 20380524142148) do

  create_table "council_wards", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "lga"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "polling_units", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "lga"
  end

  create_table "reports", force: :cascade do |t|
    t.string "election_type"
    t.string "lga"
    t.time "arrival_time"
    t.time "arrival_election_material"
    t.time "voting_started"
    t.time "voting_ended"
    t.integer "all_voters", limit: 8
    t.integer "valid_voters", limit: 8
    t.integer "invalid_voters", limit: 8
    t.integer "apc_votes", limit: 8
    t.integer "apga_votes", limit: 8
    t.integer "labour_party", limit: 8
    t.integer "pdp_votes", limit: 8
    t.integer "prp_votes", limit: 8
    t.integer "ypp_votes", limit: 8
    t.integer "total_votes", limit: 8
    t.time "result_time"
    t.string "pdp_agent"
    t.string "agent_phone"
    t.string "officer_name"
    t.string "officer_gender"
    t.string "picture"
    t.string "sheet"
    t.float "latitude"
    t.float "longitude"
    t.integer "council_ward_id"
    t.integer "polling_unit_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["council_ward_id"], name: "index_reports_on_council_ward_id"
    t.index ["polling_unit_id"], name: "index_reports_on_polling_unit_id"
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "gender"
    t.string "phone"
    t.string "token"
    t.string "type"
    t.string "address"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "image"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
