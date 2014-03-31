class CreateHotelReservations < ActiveRecord::Migration
  def change
    create_table :hotel_reservations do |t|
      t.string :GDS_Record_Locator
      t.date :Reservation_Date
      t.date :Check_In_Date
      t.date :Check_Out_Date
      t.string :Hotel_Chain_Code
      t.string :Hotel_Chain_Name
      t.string :Hotel_Property_Name
      t.string :Hotel_Address
      t.string :Hotel_City_Name
      t.string :Hotel_State
      t.string :Hotel_Zip_Code
      t.string :Hotel_Country_Code
      t.integer :Number_of_Room_Nights
      t.float :Daily_Rate
      t.string :Room_Rate_Code
      t.boolean :Online_Indicator

      t.timestamps
    end
  end
end
