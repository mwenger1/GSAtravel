class FlightReservation < ActiveRecord::Base
    before_save :days_in_advance

    def days_in_advance
        self.days_in_advance = trip_departure_date - reservation_date
    end
end
