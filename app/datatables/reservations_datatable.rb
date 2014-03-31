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
        flight.Reservation_Date,
        flight.Airline_Name,
        flight.Cabin_Class,
        flight.Total_Amount
      ]
    end
  end

  def flight_reservations
    @flight_reservations ||= fetch_flight_reservations
  end

  def fetch_flight_reservations
    flight_reservations = FlightReservation.order("#{sort_column} #{sort_direction}")
    flight_reservations = flight_reservations.page(page).per_page(per_page)
    if params[:sSearch].present?
      flight_reservations = flight_reservations.where("name like :search or category like :search", search: "%#{params[:sSearch]}%")
    end
    flight_reservations
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[Reservation_Date Airline_Name Cabin_Class Total_Amount]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
