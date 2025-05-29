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

ActiveRecord::Schema.define(version: 2025_05_29_064504) do

  create_table "access_logs", force: :cascade do |t|
    t.string "source"
    t.string "path"
    t.string "ip"
    t.datetime "accessed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "add_column_to_comments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_name"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "advances", force: :cascade do |t|
    t.integer "contract_id", null: false
    t.string "status"
    t.datetime "next"
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_advances_on_contract_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "company"
    t.string "name"
    t.string "tel"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "disclosure_clicked_at"
    t.integer "contract_id"
    t.index ["contract_id"], name: "index_clients_on_contract_id"
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true
  end

  create_table "columns", force: :cascade do |t|
    t.string "title"
    t.string "kategory"
    t.string "description"
    t.string "heading_1"
    t.string "file_1"
    t.text "content_1"
    t.string "heading_2"
    t.string "file_2"
    t.text "content_2"
    t.string "heading_3"
    t.string "file_3"
    t.text "content_3"
    t.string "heading_4"
    t.string "file_4"
    t.text "content_4"
    t.string "heading_5"
    t.string "file_5"
    t.text "content_5"
    t.string "heading_6"
    t.string "file_6"
    t.text "content_6"
    t.string "heading_7"
    t.string "file_7"
    t.text "content_7"
    t.string "heading_8"
    t.string "file_8"
    t.text "content_8"
    t.string "heading_9"
    t.string "file_9"
    t.text "content_9"
    t.string "heading_10"
    t.string "file_10"
    t.text "content_10"
    t.string "heading_11"
    t.string "file_11"
    t.string "content_11"
    t.string "heading_12"
    t.string "file_12"
    t.string "content_12"
    t.string "heading_13"
    t.string "file_13"
    t.string "content_13"
    t.string "heading_14"
    t.string "file_14"
    t.string "content_14"
    t.string "heading_15"
    t.string "file_15"
    t.string "content_15"
    t.string "heading_16"
    t.string "file_16"
    t.string "content_16"
    t.string "heading_17"
    t.string "file_17"
    t.string "content_17"
    t.string "heading_18"
    t.string "file_18"
    t.string "content_18"
    t.string "heading_19"
    t.string "file_19"
    t.string "content_19"
    t.string "heading_20"
    t.string "file_20"
    t.string "content_20"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer "estimate_id"
    t.string "asahi"
    t.string "cocacola"
    t.string "dydo"
    t.string "itoen"
    t.string "kirin"
    t.string "otsuka"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "suntory"
    t.string "yamakyu"
    t.string "neos"
    t.string "body"
    t.string "net"
    t.string "asahi_suggestion"
    t.string "asahi_remarks"
    t.string "cocacola_suggestion"
    t.string "cocacola_remarks"
    t.string "itoen_suggestion"
    t.string "itoen_remarks"
    t.string "neos_suggestion"
    t.string "neos_remarks"
    t.string "yamakyu_suggestion"
    t.string "yamakyu_remarks"
    t.string "dydo_suggestion"
    t.string "dydo_remarks"
    t.string "token"
    t.integer "client_id"
    t.string "asahi_file"
    t.string "cocacola_file"
    t.string "itoen_file"
    t.string "neos_file"
    t.string "yamakyu_file"
    t.string "dydo_file"
    t.date "inspection_start_date"
    t.index ["estimate_id"], name: "index_comments_on_estimate_id"
    t.index ["token"], name: "index_comments_on_token", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.string "company"
    t.string "name"
    t.string "tel"
    t.string "address"
    t.string "mail"
    t.string "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "client_id"
    t.index ["client_id"], name: "index_companies_on_client_id"
    t.index ["reset_password_token"], name: "index_companies_on_reset_password_token", unique: true
  end

  create_table "contracts", force: :cascade do |t|
    t.string "company"
    t.string "name"
    t.string "tel"
    t.string "email"
    t.string "address"
    t.string "period"
    t.string "area"
    t.string "message"
    t.string "post_title"
    t.string "president_name"
    t.string "agree"
    t.string "contract_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "disclosure_logs", force: :cascade do |t|
    t.integer "client_id"
    t.integer "estimate_id"
    t.string "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_disclosure_logs_on_client_id"
    t.index ["estimate_id"], name: "index_disclosure_logs_on_estimate_id"
  end

  create_table "estimates", force: :cascade do |t|
    t.string "co"
    t.string "name"
    t.string "tel"
    t.string "email"
    t.string "postnumber"
    t.string "address"
    t.string "installation"
    t.string "people"
    t.string "chenge"
    t.string "change_before"
    t.string "importance"
    t.string "period"
    t.string "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.boolean "send_mail_flag"
    t.string "vender"
    t.string "other"
    t.string "word"
    t.string "percentage_i"
    t.string "percentage_other"
    t.string "assumed_number"
    t.string "sales_price"
    t.string "assumed_total"
    t.string "aim"
    t.string "attracting"
    t.string "chagnge_remarks"
    t.string "industry"
    t.boolean "disclosed"
    t.boolean "accepted_by_client"
    t.integer "client_id"
  end

  create_table "images", force: :cascade do |t|
    t.integer "company_id"
    t.string "title"
    t.string "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_images_on_company_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "room_id"
    t.integer "estimate_id"
    t.text "content"
    t.boolean "is_user"
    t.boolean "is_read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer "estimate_id"
    t.string "year"
    t.string "month"
    t.string "sales"
    t.boolean "complete", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["estimate_id"], name: "index_payments_on_estimate_id"
  end

  create_table "progresses", force: :cascade do |t|
    t.integer "estimate_id"
    t.string "status"
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "admin_id"
    t.string "document"
    t.date "next"
    t.integer "purchase_id"
    t.index ["estimate_id"], name: "index_progresses_on_estimate_id"
    t.index ["purchase_id"], name: "index_progresses_on_purchase_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.string "co"
    t.string "name"
    t.string "tel"
    t.string "address"
    t.string "email"
    t.string "vender"
    t.string "installment"
    t.string "option"
    t.string "period"
    t.string "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "simpel_wrapping"
    t.string "thousand"
    t.string "five_hundred"
    t.string "five_ensure"
    t.string "simple_wrapping"
    t.string "design_wrapping"
  end

  create_table "questions", force: :cascade do |t|
    t.string "whats"
    t.string "category"
    t.string "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reports", force: :cascade do |t|
    t.integer "purchase_id"
    t.string "status"
    t.datetime "next"
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["purchase_id"], name: "index_reports_on_purchase_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "member_id", null: false
    t.text "uri_token", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transfers", force: :cascade do |t|
    t.integer "estimate_id"
    t.string "bank"
    t.string "branch"
    t.string "number"
    t.string "name"
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "document"
    t.index ["estimate_id"], name: "index_transfers_on_estimate_id"
  end

end
