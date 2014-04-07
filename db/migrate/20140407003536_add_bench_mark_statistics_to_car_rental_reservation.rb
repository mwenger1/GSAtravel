class AddBenchMarkStatisticsToCarRentalReservation < ActiveRecord::Migration
  def change
    add_column :car_rental_reservations, :benchmark_rate, :float
    add_column :car_rental_reservations, :benchmark_rate_percentage, :float
    add_column :car_rental_reservations, :benchmark_rate_difference, :float
  end
end
