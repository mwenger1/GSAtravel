class DashboardController < ApplicationController
before_filter :authenticate_user!

  def overview
  end

  def transactions
    @flight_reservations = FlightReservation.find(:all, :order => "id desc", :limit => 300)
  end

  def budgets
  end

  def trends
  end

  def ways_to_save
  end
end
