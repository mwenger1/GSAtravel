class DepartmentOverviewDatatable
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
        flight.gds_record_locator,
        flight.reservation_date.strftime('%b %d, %Y'),
        flight.days_in_advance,
        flight.airline_name
      ]
    end
  end

  def flight_reservations
    @flight_reservations ||= fetch_flight_reservations
  end

  def fetch_flight_reservations
    flight_reservations = FlightReservation.order("#{sort_column} #{sort_direction}").limit(10)
    if params[:sSearch].present?
      flight_reservations = flight_reservations.where("gds_record_locator like :search or airline_name like :search", search: "%#{params[:sSearch]}%")
    end
    flight_reservations = flight_reservations.where(:reservation_date => Date.new(2007, 5, 12)..Date.new(2010, 10, 12))
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
    columns = %w[gds_record_locator gds_record_locator reservation_date days_in_advance airline_name]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
