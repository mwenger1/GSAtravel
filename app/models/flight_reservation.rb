class FlightReservation < ActiveRecord::Base
    before_save :days_in_advance, :calculate_benchmark_percentage, :calculate_benchmark_difference

    def days_in_advance
        self.days_in_advance = (self.trip_departure_date - self.reservation_date).to_i
    end
    def calculate_benchmark_percentage
        self.benchmark_rate_percentage = (((self.benchmark_rate* 100)/ self.total_amount)-100).to_f.round(2)
    end

    def calculate_benchmark_difference
        self.benchmark_rate_difference = (self.benchmark_rate - self.total_amount).to_f
    end
end
