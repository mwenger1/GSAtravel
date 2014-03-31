class DashboardController < ApplicationController
before_filter :authenticate_user!

  def overview
  end

  def transactions
    respond_to do |format|
      format.html
      format.json{ render json: ReservationsDatatable.new(view_context)}
    # @flight_reservations = FlightReservation.find(:all, :order => "id desc", :limit => 300)
    end
  end

  def budgets
  end

  def trends
  end

  def ways_to_save
  end
end
