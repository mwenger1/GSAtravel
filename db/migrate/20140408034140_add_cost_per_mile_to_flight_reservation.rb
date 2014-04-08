class AddCostPerMileToFlightReservation < ActiveRecord::Migration
  def change
    add_column :flight_reservations, :cost_per_mile, :float
  end
end
