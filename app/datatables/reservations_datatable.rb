class ReservationsDatatable
  delegate :params, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: FlightReservation.count,
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
        number_to_currency(flight.benchmark_rate_difference),
        flight.benchmark_rate_percentage,
        flight.ticket_number,
        flight.online_indicator,
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
      flight_reservations = flight_reservations.where("gds_record_locator like :search or airline_name like :search", search: "%#{params[:sSearch]}%")
    end
    if params[:airline_name].present?
      flight_reservations = flight_reservations.where(:airline_name => params[:airline_name])
    end

    if params[:start_date].present?
      flight_reservations = flight_reservations.where(:reservation_date => params[:start_date]..params[:end_date])
      raise params[:start_date]
    end

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
    columns = %w[gds_record_locator gds_record_locator reservation_date days_in_advance airline_name fare_category benchmark_rate total_amount benchmark_rate_difference benchmark_rate_percentage ticket_number]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
