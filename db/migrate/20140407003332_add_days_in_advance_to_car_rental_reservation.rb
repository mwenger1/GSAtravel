class AddDaysInAdvanceToCarRentalReservation < ActiveRecord::Migration
  def change
    add_column :car_rental_reservations, :days_in_advance, :integer
  end
end
