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
    department_data = [
      ["GSA","$34M","$9K","30%", "5%", "34"],
      ["NIH","$32M","$3K","22%", "3%", "14"], 
      ["IRS","$28M","$8K","25%", "6%", "28"], 
      ["EPA","$45M","$2K","35%", "12%", "40"], 
      ["FEMA","$20M","$11K","5%", "20%", "36"], 
      ["DoJ","$5M","$1K","14%", "1%", "34"],
      ["FBI","$61M","$10K","17%", "0%", "39"],
      ["CIA","$47M","$10K","35%", "0%", "55"],
      ["DE","$23M","$2K","2%", "2%", "5"],
      ["DHS","$33M","$2K","0%", "3%", "16"],
      ["USDA","$29M","$3K","28%", "5%", "39"]
    ]
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
