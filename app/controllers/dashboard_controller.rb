class DashboardController < ApplicationController
before_filter :authenticate_user!, :except => [:transactions,:transactions_data]
before_filter :set_date
require 'gchart'
  def overview
        @line_chart = Gchart.line(:data => [0, 40, 10, 70, 20],:legend => 'Mike\'s test table', :axis_with_labels => 'y,x')



        data = [24,25,25,25,25,27,100,31,25,36,25,25,39,25,31,25,25,25,26,26,25,25,28,25,25,100,28,27,31,25,27,27,29,25,27,26,26,25,26,26,35,33,34,25,26,25,36,25,26,37,33,33,37,37,39,25,25,25,25]
      @sparkline_chart = Gchart.sparkline(:data => data, :size => '120x40', :line_colors => '0077CC')



      @piechart = Gchart.pie_3d(:data => [20, 35, 45])



      @scatter_chart = Gchart.scatter(:data => [[1, 2, 3, 4, 5], [1, 2, 3, 4 ,5], [5, 4, 3, 2, 1]])



      @barchart = Gchart.bar(:title => "Matt's Mojo",
               :data => [15, 30, 10, 20, 100, 20, 40, 100, 90, 100, 80],
               :bar_colors => '76A4FB',
               :background => 'EEEEEE', :chart_background => 'CCCCCC')
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
    @vendor_flight_pie = Gchart.pie(:data => [10, 35, 55])
    @vendor_hotel_pie = Gchart.pie(:data => [20, 35, 45])
    @vendor_car_rental_pie = Gchart.pie(:data => [40, 35, 25])

    data_table = GoogleVisualr::DataTable.new
    # Add Column Headers
    data_table.new_column('string', 'Year' )
    data_table.new_column('number', 'Sales')
    data_table.new_column('number', 'Expenses')

    # Add Rows and Values
    data_table.add_rows([
        ['2004', 1000, 400],
        ['2005', 1170, 460],
        ['2006', 660, 1120],
        ['2007', 1030, 540]
    ])
    option = { width: 400, height: 240, title: 'Company Performance' }
    @chart = GoogleVisualr::Interactive::AreaChart.new(data_table, option)
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
