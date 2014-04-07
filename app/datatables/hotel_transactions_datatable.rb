class HotelTransactionsDatatable
  delegate :params, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
    @start_date =  Date.parse(params[:start_date]) #Date.parse() #Date.new(2007, 5, 12)
    @end_date = Date.parse(params[:end_date]) #Date.parse() # Date.new(2007, 5, 12)
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: hotel_transactions.count,
      iTotalDisplayRecords: hotel_transactions.total_entries,
      aaData: data
    }
  end

private

  def data
    hotel_transactions.map do |hotel|
      [
        '<img src="http://datatables.net/release-datatables/examples/examples_support/details_open.png">',
        hotel.gds_record_locator,
        hotel.reservation_date.strftime('%b %d, %Y'),
        hotel.days_in_advance,
        hotel.hotel_chain_name,
        hotel.hotel_city_name,
        number_to_currency(hotel.daily_rate),
        number_to_currency(hotel.daily_rate),
        hotel.online_indicator,
        hotel.hotel_chain_name,
        hotel.hotel_chain_name,
        hotel.hotel_chain_name,
        hotel.hotel_chain_name,
        hotel.hotel_chain_name,
        hotel.hotel_chain_name,
        hotel.hotel_chain_name,
      ]
    end
  end

  def hotel_transactions
    @hotel_transactions ||= fetch_hotel_transactions
  end

  def fetch_hotel_transactions
    hotel_transactions = HotelReservation.order("#{sort_column} #{sort_direction}")
    if params[:sSearch].present?
      hotel_transactions = hotel_transactions.where("LOWER(gds_record_locator) like LOWER(:search) or LOWER(airline_name) like LOWER(:search)", search: "%#{params[:sSearch]}%")
    end

    hotel_transactions = hotel_transactions.where(:reservation_date => @start_date.beginning_of_day..@end_date.end_of_day)

    hotel_transactions = hotel_transactions.page(page).per_page(per_page)
    hotel_transactions
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
