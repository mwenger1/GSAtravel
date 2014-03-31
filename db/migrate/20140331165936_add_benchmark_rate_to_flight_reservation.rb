class AddBenchmarkRateToFlightReservation < ActiveRecord::Migration
  def change
    add_column :flight_reservations, :benchmark_rate, :float
  end
end
