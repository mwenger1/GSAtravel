class FlightReservation < ActiveRecord::Base
    before_save :days_in_advance, :calculate_benchmark_percentage, :calculate_benchmark_difference

    def days_in_advance
        self.days_in_advance = trip_departure_date - reservation_date
    end
    def calculate_benchmark_percentage
        self.benchmark_rate_percentage = (((benchmark_rate* 100)/ total_amount)-100).round(2)
    end

    def calculate_benchmark_difference
        self.benchmark_rate_difference = benchmark_rate - total_amount
    end
end
