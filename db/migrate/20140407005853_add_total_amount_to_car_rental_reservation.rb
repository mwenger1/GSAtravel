class AddTotalAmountToCarRentalReservation < ActiveRecord::Migration
  def change
    add_column :car_rental_reservations, :total_amount, :float
  end
end
