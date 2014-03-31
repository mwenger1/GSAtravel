class AddBenchmarkRateDifferenceToFlightReservation < ActiveRecord::Migration
  def change
    add_column :flight_reservations, :benchmark_rate_difference, :float
  end
end
