class AddTotalAmountToHotelReservations < ActiveRecord::Migration
  def change
    add_column :hotel_reservations, :total_amount, :float
  end
end
