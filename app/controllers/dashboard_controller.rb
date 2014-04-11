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
      @start_date = Date.new(2007, 5, 12) #params[:start_date]
      @end_date = Date.new(2010, 5, 12) #params[:end_date]
@flights_per_airline = (FlightReservation.group(:airline_name).order(:airline_name).count).to_a.unshift(["Airline","Flights"])
@percentage_per_airline = (FlightReservation.group(:airline_name).order(:airline_name).sum(:total_amount)).to_a.unshift(["Airline","Total Amount"])


      format.html
      format.json{ render json: {
        "flights_per_airline"=>@flights_per_airline,
        "percentage_per_airline"=>@percentage_per_airline,
        "destination_airport_count"=>FlightReservation.group(:destination_airport_code).order(:destination_airport_code).count,
        "totalcost_per_airline"=>FlightReservation.group(:airline_name).sum(:total_amount),
        "transaction_type_total_cost"=> {
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

    @flight_map_data = FlightReservation.group(:destination_airport_code).order(:destination_airport_code).count.to_a.unshift(["City","Count"])


    # [
    #     ['Country',   'Population', 'Area Percentage'],
    #     ['France',  65700000, 50],
    #     ['Germany', 81890000, 27],
    #     ['Poland',  38540000, 23],
    #     ['Italy',  38540000, 23],
    #   ]
    render layout: false

  end


  def calendar_chart

    # @flight_calendar_data = "[
    #      [ new Date(2012, 3, 13), 37032 ],
    #       [ new Date(2012, 3, 14), 38024 ],
    #       [ new Date(2012, 3, 15), 38024 ],
    #       [ new Date(2012, 3, 16), 38108 ],
    #       [ new Date(2012, 4, 16), 38108 ],
    #       [ new Date(2012, 5, 16), 38108 ],

    #       [ new Date(2012, 3, 17), 38229 ],
    #       [ new Date(2013, 9, 4), 38177 ],
    #       [ new Date(2013, 9, 5), 38705 ],
    #       [ new Date(2013, 9, 12), 38210 ],
    #       [ new Date(2013, 9, 13), 38029 ],
    #       [ new Date(2013, 9, 19), 38823 ],
    #       [ new Date(2013, 9, 23), 38345 ],
    #       [ new Date(2013, 9, 24), 38436 ],
    #       [ new Date(2013, 9, 30), 38447 ]
    #     ]"

       # @flight_calendar_data = FlightReservation.group(:trip_departure_date).order(:trip_departure_date).count.to_a
      # @tmpString = ""
      @flight = FlightReservation.all
 # @flight_calendar_data = FlightReservation.group(:trip_departure_date).order(:trip_departure_date).count.each{|k,v| (@tmpString .= "[#{k}, #{v}],")}
    render layout: false

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
