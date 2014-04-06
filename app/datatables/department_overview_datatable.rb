class DepartmentOverviewDatatable
  delegate :params, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: FlightReservation.count,
      iTotalDisplayRecords: flight_reservations.count,
      aaData: flight_reservations
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
    @flight_reservations ||= fetch_department_data
  end

  def fetch_department_data
    department_data = [["GSA","$34M"],["IRS","$32M"]]
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[department amount]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end