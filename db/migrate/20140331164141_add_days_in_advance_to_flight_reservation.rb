class AddDaysInAdvanceToFlightReservation < ActiveRecord::Migration
  def change
    add_column :flight_reservations, :days_in_advance, :integer
  end
end
