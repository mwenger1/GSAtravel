class AddBenchMarkStatisticsToHotelReservation < ActiveRecord::Migration
  def change
    add_column :hotel_reservations, :benchmark_rate, :float
    add_column :hotel_reservations, :benchmark_rate_percentage, :float
    add_column :hotel_reservations, :benchmark_rate_difference, :float
  end
end
