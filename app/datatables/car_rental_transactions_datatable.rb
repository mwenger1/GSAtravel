class CarRentalTransactionsDatatable
  delegate :params, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
    @start_date =  Date.parse(params[:start_date]) #Date.parse() #Date.new(2007, 5, 12)
    @end_date = Date.parse(params[:end_date]) #Date.parse() # Date.new(2007, 5, 12)
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: flight_reservations.count,
      iTotalDisplayRecords: flight_reservations.total_entries,
      aaData: data
    }
  end

private

  def data
    flight_reservations.map do |flight|
      [
        '<img src="http://datatables.net/release-datatables/examples/examples_support/details_open.png">',
        flight.gds_record_locator,
        flight.reservation_date.strftime('%b %d, %Y'),
        flight.days_in_advance,
        flight.airline_name,
        flight.fare_category,
        number_to_currency(flight.benchmark_rate),
        number_to_currency(flight.total_amount),
        flight.online_indicator,
        number_to_currency(flight.benchmark_rate_difference),
        flight.benchmark_rate_percentage,
        flight.ticket_number,
        flight.mileage,
        flight.routing,
        flight.domestic_international_indicator,
        flight.trip_departure_date
      ]
    end
  end

  def flight_reservations
    @flight_reservations ||= fetch_flight_reservations
  end

  def fetch_flight_reservations
    flight_reservations = FlightReservation.order("#{sort_column} #{sort_direction}")
    if params[:sSearch].present?
      flight_reservations = flight_reservations.where("LOWER(gds_record_locator) like LOWER(:search) or LOWER(airline_name) like LOWER(:search)", search: "%#{params[:sSearch]}%")
    end

    flight_reservations = flight_reservations.where(:reservation_date => @start_date.beginning_of_day..@end_date.end_of_day)

    flight_reservations = flight_reservations.page(page).per_page(per_page)
    flight_reservations
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[gds_record_locator gds_record_locator reservation_date days_in_advance airline_name fare_category benchmark_rate total_amount online_indicator]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  def set_date_filter

  end

end