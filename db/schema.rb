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

ActiveRecord::Schema.define(version: 20140407005853) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "car_rental_reservations", force: true do |t|
    t.string   "gds_record_locator"
    t.date     "reservation_date"
    t.date     "car_pick_up_date"
    t.date     "car_drop_off_date"
    t.string   "car_chain_code"
    t.string   "car_chain_name"
    t.string   "car_pick_up_city"
    t.string   "car_pick_up_state"
    t.string   "car_drop_off_city"
    t.string   "car_drop_off_state"
    t.integer  "car_rental_days"
    t.float    "car_daily_rate"
    t.string   "car_category"
    t.string   "online_indicator"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "days_in_advance"
    t.float    "benchmark_rate"
    t.float    "benchmark_rate_percentage"
    t.float    "benchmark_rate_difference"
    t.float    "total_amount"
  end

  create_table "flight_reservations", force: true do |t|
    t.string   "gds_record_locator"
    t.date     "reservation_date"
    t.date     "ticket_issue_date"
    t.date     "trip_departure_date"
    t.string   "ticket_number"
    t.string   "airline_name"
    t.string   "cabin_class"
    t.string   "domestic_international_indicator"
    t.string   "origin_airport_code"
    t.string   "destination_airport_code"
    t.string   "routing"
    t.float    "invoice_amount"
    t.float    "tax_amount"
    t.float    "total_amount"
    t.float    "mileage"
    t.string   "exchange_indicator"
    t.string   "exchange_original_ticket_number"
    t.string   "refund_indicator"
    t.string   "original_invoice_number"
    t.string   "online_indicator"
    t.string   "fare_category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "days_in_advance"
    t.float    "benchmark_rate"
    t.float    "benchmark_rate_percentage"
    t.float    "benchmark_rate_difference"
  end

  create_table "hotel_reservations", force: true do |t|
    t.string   "gds_record_locator"
    t.date     "reservation_date"
    t.date     "check_in_date"
    t.date     "check_out_date"
    t.string   "hotel_chain_code"
    t.string   "hotel_chain_name"
    t.string   "hotel_property_name"
    t.string   "hotel_address"
    t.string   "hotel_city_name"
    t.string   "hotel_state"
    t.string   "hotel_zip_code"
    t.string   "hotel_country_code"
    t.integer  "number_of_room_nights"
    t.float    "daily_rate"
    t.string   "room_rate_code"
    t.boolean  "online_indicator"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "days_in_advance"
    t.float    "benchmark_rate"
    t.float    "benchmark_rate_percentage"
    t.float    "benchmark_rate_difference"
  end

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
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
