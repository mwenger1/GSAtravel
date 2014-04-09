class DashboardController < ApplicationController
before_filter :authenticate_user!, :except => [:transactions,:transactions_data]
before_filter :set_date
  def overview
  end



  def transactions
  end

  def transactions_flight_data
    respond_to do |format|
      format.html
      format.json{ render json: ReservationsDatatable.new(view_context)}
    end
  end

  def transactions_car_rental_data
    respond_to do |format|
      format.html
      format.json{ render json: CarRentalTransactionsDatatable.new(view_context)}
    end
  end

  def transactions_hotel_data
    respond_to do |format|
      format.html
      format.json{ render json: HotelTransactionsDatatable.new(view_context)}
    end
  end

  def flight_vendor_data
    respond_to do |format|
      format.html
      format.json{ render json: {
        "airlinecount"=>FlightReservation.group(:airline_name).count,
        "airportcodecount"=>FlightReservation.group(:origin_airport_code).count,
        "totalairlinecost"=>FlightReservation.group(:airline_name).sum(:total_amount),
        "TotalCost"=> {
                        "flights" => FlightReservation.sum(:total_amount),
                        "hotels" => HotelReservation.sum(:total_amount),
                        "car_rentals" => CarRentalReservation.sum(:total_amount)
                      }

        }
      }
    end
  end


  def overview_data
    respond_to do |format|
      format.html
      format.json{ render json: DepartmentOverviewDatatable.new(view_context)}
    # @flight_reservations = FlightReservation.find(:all, :order => "id desc", :limit => 300)
    end
  end

  def budgets
  end

  def trends
  end

  def ways_to_save
  end

  def airport_api
    require 'rest_client'
    @data = RestClient.get "https://airport.api.aero/airport/#{params[:airport_code]}?user_key=d9e2c9a6cad452d0e6f9ee9bd2f5cd0b&callback", {:accept => :json}
    render json: @data
  end

  private
  def set_date
    @date = Date.today.strftime('%b %d, %Y')
    @date_in_past = Date.new(2010,1,1).strftime('%b %d, %Y')

  end
end
