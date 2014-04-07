class HotelReservation < ActiveRecord::Base
    before_save :days_in_advance
    def days_in_advance
        self.days_in_advance = (self.check_in_date - self.reservation_date).to_i
    end
end
