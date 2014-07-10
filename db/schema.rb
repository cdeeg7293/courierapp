# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140503182027) do

  create_table "addresses", force: true do |t|
    t.string   "city"
    t.string   "street"
    t.string   "building"
    t.integer  "apartment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "clients", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "address_id"
    t.string   "first_name"
    t.string   "patronymic"
    t.string   "last_name"
    t.boolean  "is_person"
  end

  add_index "clients", ["address_id"], name: "index_clients_on_address_id", using: :btree

  create_table "contact_types", force: true do |t|
    t.string   "type_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "value"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contact_type_id"
  end

  add_index "contacts", ["client_id"], name: "index_contacts_on_client_id", using: :btree
  add_index "contacts", ["contact_type_id"], name: "index_contacts_on_contact_type_id", using: :btree

  create_table "couriers", force: true do |t|
    t.integer  "client_id"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "couriers", ["address_id"], name: "index_couriers_on_address_id", using: :btree
  add_index "couriers", ["client_id"], name: "index_couriers_on_client_id", using: :btree

  create_table "order_statuses", force: true do |t|
    t.integer  "order_id"
    t.integer  "courier_id"
    t.datetime "date_planned"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "order_statuses", ["courier_id"], name: "index_order_statuses_on_courier_id", using: :btree
  add_index "order_statuses", ["order_id"], name: "index_order_statuses_on_order_id", using: :btree

  create_table "orders", force: true do |t|
    t.integer  "number"
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.decimal  "sum"
    t.datetime "delivered_date"
    t.datetime "issued_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["receiver_id"], name: "index_orders_on_receiver_id", using: :btree
  add_index "orders", ["sender_id"], name: "index_orders_on_sender_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
