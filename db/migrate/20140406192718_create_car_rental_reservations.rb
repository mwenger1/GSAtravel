class CreateCarRentalReservations < ActiveRecord::Migration
  def change
    create_table :car_rental_reservations do |t|
      t.string :gds_record_locator
      t.date :reservation_date
      t.date :car_pick_up_date
      t.date :car_drop_off_date
      t.string :car_chain_code
      t.string :car_chain_name
      t.string :car_pick_up_city
      t.string :car_pick_up_state
      t.string :car_drop_off_city
      t.string :car_drop_off_state
      t.integer :car_rental_days
      t.float :car_daily_rate
      t.string :car_category
      t.string :online_indicator

      t.timestamps
    end
  end
end
