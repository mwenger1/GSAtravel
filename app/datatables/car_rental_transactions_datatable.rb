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
      iTotalRecords: car_rental_transactions.count,
      iTotalDisplayRecords: car_rental_transactions.total_entries,
      aaData: data
    }
  end

private

  def data
    car_rental_transactions.map do |rental|
      [
        rental.gds_record_locator,
        rental.car_pick_up_date.strftime('%b %d, %Y'),
        rental.days_in_advance.to_s + " days",
        rental.car_pick_up_city,
        rental.car_chain_name.titleize,
        rental.car_category,
        rental.online_indicator,
        number_to_currency(rental.car_daily_rate),
        rental.car_rental_days,
        number_to_currency(rental.total_amount),
        number_to_currency(rental.total_amount),
        number_to_currency(rental.total_amount),
        rental.gds_record_locator,
        rental.gds_record_locator,
        rental.gds_record_locator
      ]
    end
  end

  def car_rental_transactions
    @car_rental_transactions ||= fetch_car_rental_transactions
  end

  def fetch_car_rental_transactions
    car_rental_transactions = CarRentalReservation.order("#{sort_column} #{sort_direction}")
    if params[:sSearch].present?
      car_rental_transactions = car_rental_transactions.where("LOWER(gds_record_locator) like LOWER(:search) or LOWER(car_chain_name) like LOWER(:search)", search: "%#{params[:sSearch]}%")
    end

    car_rental_transactions = car_rental_transactions.where(:reservation_date => @start_date.beginning_of_day..@end_date.end_of_day)

    car_rental_transactions = car_rental_transactions.page(page).per_page(per_page)
    car_rental_transactions
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[gds_record_locator car_pick_up_date days_in_advance car_pick_up_city car_chain_name car_category online_indicator car_daily_rate car_rental_days total_amount ]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  def set_date_filter

  end

end
