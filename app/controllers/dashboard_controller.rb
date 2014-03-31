class DashboardController < ApplicationController
before_filter :authenticate_user!, :except => [:transactions,:transactions_data]

  def overview
  end

  def transactions
  end

  def transactions_data
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
