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

ActiveRecord::Schema.define(version: 20140331164141) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
  end

  create_table "hotel_reservations", force: true do |t|
    t.string   "GDS_Record_Locator"
    t.date     "Reservation_Date"
    t.date     "Check_In_Date"
    t.date     "Check_Out_Date"
    t.string   "Hotel_Chain_Code"
    t.string   "Hotel_Chain_Name"
    t.string   "Hotel_Property_Name"
    t.string   "Hotel_Address"
    t.string   "Hotel_City_Name"
    t.string   "Hotel_State"
    t.string   "Hotel_Zip_Code"
    t.string   "Hotel_Country_Code"
    t.integer  "Number_of_Room_Nights"
    t.float    "Daily_Rate"
    t.string   "Room_Rate_Code"
    t.boolean  "Online_Indicator"
    t.datetime "created_at"
    t.datetime "updated_at"
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
