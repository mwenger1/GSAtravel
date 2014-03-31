class CreateFlightReservations < ActiveRecord::Migration
  def change
    create_table :flight_reservations do |t|
      t.string :gds_record_locator
      t.date :reservation_date
      t.date :ticket_issue_date
      t.date :trip_departure_date
      t.string :ticket_number
      t.string :airline_name
      t.string :cabin_class
      t.string :domestic_international_indicator
      t.string :origin_airport_code
      t.string :destination_airport_code
      t.string :routing
      t.float :invoice_amount
      t.float :tax_amount
      t.float :total_amount
      t.float :mileage
      t.string :exchange_indicator
      t.string :exchange_original_ticket_number
      t.string :refund_indicator
      t.string :original_invoice_number
      t.string :online_indicator
      t.string :fare_category

      t.timestamps
    end
  end
end
