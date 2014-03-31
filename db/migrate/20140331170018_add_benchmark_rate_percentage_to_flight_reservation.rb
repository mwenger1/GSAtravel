class AddBenchmarkRatePercentageToFlightReservation < ActiveRecord::Migration
  def change
    add_column :flight_reservations, :benchmark_rate_percentage, :float
  end
end
