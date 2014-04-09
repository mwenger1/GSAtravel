class ChangeBooleanFormatInHotelReservations < ActiveRecord::Migration
    def self.up
        change_column :hotel_reservations, :online_indicator, :string
    end

  def self.down
   change_column :hotel_reservations, :online_indicator, :boolean
  end
end
