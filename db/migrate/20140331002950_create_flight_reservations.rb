class CreateFlightReservations < ActiveRecord::Migration
  def change
    create_table :flight_reservations do |t|
      t.string :GDS_Record_Locator
      t.date :Reservation_Date
      t.date :Ticket_Issue_Date
      t.date :Trip_Departure_Date
      t.string :Ticket_Number
      t.string :Airline_Name
      t.string :Cabin_Class
      t.string :Domestic_/_International_Indicator
      t.string :Origin_Airport_Code
      t.string :Destination_Airport_Code
      t.string :Routing
      t.float :Invoice_Amount
      t.float :Tax_Amount
      t.float :Total_Amount
      t.float :Mileage
      t.string :Exchange_Indicator
      t.string :Exchange_Original_Ticket_Number
      t.string :Refund__Indicator
      t.string :Original_Invoice_Number
      t.string :Online_Indicator
      t.string :Fare_Category

      t.timestamps
    end
  end
end
