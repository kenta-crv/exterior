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

ActiveRecord::Schema.define(version: 2025_06_30_074323) do

  create_table "access_logs", force: :cascade do |t|
    t.string "source"
    t.string "path"
    t.string "ip"
    t.datetime "accessed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "client_comments", force: :cascade do |t|
    t.integer "estimate_id"
    t.integer "client_id"
    t.string "status"
    t.text "remarks"
    t.date "sent_date"
    t.date "inspection_start_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_client_comments_on_client_id"
    t.index ["estimate_id"], name: "index_client_comments_on_estimate_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "company"
    t.string "representative_name"
    t.string "representative_kana"
    t.string "contact_name"
    t.string "contact_kana"
    t.string "tel"
    t.string "address"
    t.string "url"
    t.string "area"
    t.string "question_area"
    t.string "question_price"
    t.string "question_tax"
    t.string "question_responce"
    t.string "question_contract"
    t.string "question_picture"
    t.text "question_appeal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "disclosure_clicked_at"
    t.integer "contract_id"
    t.string "post_title"
    t.string "agree"
    t.date "contract_date"
    t.string "agree_1"
    t.string "agree_2"
    t.string "agree_3"
    t.string "agree_4"
    t.string "agree_5"
    t.string "agree_6"
    t.string "agree_7"
    t.string "agree_8"
    t.string "agree_9"
    t.string "face"
    t.string "logo"
    t.string "before_1"
    t.string "after_1"
    t.string "before_2"
    t.string "after_2"
    t.string "before_3"
    t.string "other_1"
    t.string "other_2"
    t.string "other_3"
    t.string "after_3"
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
    t.integer "client_id"
    t.json "net_info"
    t.date "inspection_start_date"
    t.string "status"
    t.string "status_info"
    t.string "file"
    t.string "remarks"
    t.index ["estimate_id"], name: "index_comments_on_estimate_id"
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
    t.integer "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_contracts_on_client_id"
  end

  create_table "estimates", force: :cascade do |t|
    t.string "co"
    t.string "name"
    t.string "tel"
    t.string "postnumber"
    t.string "address"
    t.string "email"
    t.string "which_one"
    t.string "square_meter"
    t.string "schedule"
    t.string "bring"
    t.string "importance"
    t.string "period"
    t.string "remarks"
    t.integer "user_id"
    t.boolean "send_mail_flag", default: false
    t.boolean "disclosed"
    t.boolean "accepted_by_client"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "progresses", force: :cascade do |t|
    t.integer "estimate_id"
    t.string "status"
    t.string "body"
    t.integer "admin_id"
    t.string "document"
    t.date "next"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["estimate_id"], name: "index_progresses_on_estimate_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "member_id", null: false
    t.text "uri_token", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
