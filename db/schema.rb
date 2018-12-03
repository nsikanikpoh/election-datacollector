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

ActiveRecord::Schema.define(version: 20180654385233333230) do

  create_table "affiliations", force: :cascade do |t|
    t.integer "affiliate_id"
    t.integer "referred_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "type", limit: 30
    t.integer "width"
    t.integer "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "collages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "commenter_id"
    t.string "commenter_type"
    t.string "attachment"
    t.index ["commenter_type", "commenter_id"], name: "index_comments_on_commenter_type_and_commenter_id"
    t.index ["post_id"], name: "index_comments_on_post_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pros_id"
    t.string "pros_type"
    t.integer "fund_raiser_id"
    t.index ["fund_raiser_id"], name: "index_conversations_on_fund_raiser_id"
    t.index ["pros_type", "pros_id"], name: "index_conversations_on_pros_type_and_pros_id"
  end

  create_table "donations", force: :cascade do |t|
    t.integer "line"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.integer "interest_line_id"
    t.integer "donator_id"
    t.string "donator_type"
    t.date "expires_on"
    t.string "channel"
    t.string "reference"
    t.string "gateway_response"
    t.string "currency"
    t.string "status"
    t.index ["donator_type", "donator_id"], name: "index_donations_on_donator_type_and_donator_id"
  end

  create_table "interest_lines", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pics", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "collage_id"
    t.string "picture"
    t.index ["collage_id"], name: "index_pics_on_collage_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "file"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "quick_donations", force: :cascade do |t|
    t.string "name"
    t.string "tel"
    t.string "email"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.string "channel"
    t.string "reference"
    t.string "gateway_response"
    t.string "currency"
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
    t.string "name"
    t.string "image"
    t.string "title"
    t.string "gender"
    t.string "phone"
    t.string "address"
    t.date "birthday"
    t.string "location"
    t.string "state"
    t.string "provider", limit: 50, default: "", null: false
    t.string "uid", limit: 500, default: "", null: false
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
    t.integer "referrer_code"
    t.integer "affiliate_code"
    t.string "token", null: false
    t.string "type"
    t.integer "interest_line_id"
    t.integer "patriot_id"
    t.integer "fund_raiser_id"
    t.string "s_type", default: "Member", null: false
    t.integer "opportunity"
    t.integer "qualified"
    t.string "fundraiser_email"
    t.string "crm_id"
    t.string "url"
    t.datetime "created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["token"], name: "index_users_on_token", unique: true
  end

end
