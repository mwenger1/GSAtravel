class HotelReservation < ActiveRecord::Base
 before_save :days_in_advance, :calculate_benchmark_percentage, :calculate_benchmark_difference
    def days_in_advance
        self.days_in_advance = (self.car_pick_up_date - self.reservation_date).to_i
    end
end
