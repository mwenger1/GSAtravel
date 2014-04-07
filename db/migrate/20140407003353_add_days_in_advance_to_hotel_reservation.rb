class AddDaysInAdvanceToHotelReservation < ActiveRecord::Migration
  def change
    add_column :hotel_reservations, :days_in_advance, :integer
  end
end
