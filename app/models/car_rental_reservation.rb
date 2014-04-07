class CarRentalReservation < ActiveRecord::Base
    before_save :days_in_advance, :calculate_total_cost
    def days_in_advance
        self.days_in_advance = (self.car_pick_up_date - self.reservation_date).to_i
    end

    def calculate_total_cost
        self.total_amount = self.car_rental_days * self.car_daily_rate
    end
end
