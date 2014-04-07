class CarRentalReservation < ActiveRecord::Base
    before_save :days_in_advance
    def days_in_advance
        self.days_in_advance = (self.car_pick_up_date - self.reservation_date).to_i
    end
end
