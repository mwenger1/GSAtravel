class CreateHotelReservations < ActiveRecord::Migration
  def change
    create_table :hotel_reservations do |t|
      t.string :gds_record_locator
      t.date :reservation_date
      t.date :check_in_date
      t.date :check_out_date
      t.string :hotel_chain_code
      t.string :hotel_chain_name
      t.string :hotel_property_name
      t.string :hotel_address
      t.string :hotel_city_name
      t.string :hotel_state
      t.string :hotel_zip_code
      t.string :hotel_country_code
      t.integer :number_of_room_nights
      t.float :daily_rate
      t.string :room_rate_code
      t.boolean :online_indicator

      t.timestamps
    end
  end
end
