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
    # @vendor_flight_pie = Gchart.pie(:data => [10, 35, 55])
    # @vendor_hotel_pie = Gchart.pie(:data => [20, 35, 45])
    # @vendor_car_rental_pie = Gchart.pie(:data => [40, 35, 25])

# FLIGHTS BY AIRLINE
 data_table = GoogleVisualr::DataTable.new
  data_table.new_column('string', 'Task')
  data_table.new_column('number', 'Hours per Day')
  data_table.add_rows(5)
  data_table.set_cell(0, 0, 'American Airlines'     )
  data_table.set_cell(0, 1, 11 )
  data_table.set_cell(1, 0, 'United'      )
  data_table.set_cell(1, 1, 2  )
  data_table.set_cell(2, 0, 'Jet Blue'  )
  data_table.set_cell(2, 1, 2  )
  data_table.set_cell(3, 0, 'South West' )
  data_table.set_cell(3, 1, 2  )
  data_table.set_cell(4, 0, 'Luthsana'    )
  data_table.set_cell(4, 1, 7  )

  opts   = { :width => 500, :height => 350, :title => 'Flights by Airline' }
  @vendor_flight_pie = GoogleVisualr::Interactive::PieChart.new(data_table, opts)

  # COST BY AIRLINE
 data_table = GoogleVisualr::DataTable.new
  data_table.new_column('string', 'Task')
  data_table.new_column('number', 'Hours per Day')
  data_table.add_rows(5)
  data_table.set_cell(0, 0, 'American Airlines'     )
  data_table.set_cell(0, 1, 7 )
  data_table.set_cell(1, 0, 'United'      )
  data_table.set_cell(1, 1, 11  )
  data_table.set_cell(2, 0, 'Jet Blue'  )
  data_table.set_cell(2, 1, 2  )
  data_table.set_cell(3, 0, 'South West' )
  data_table.set_cell(3, 1, 2  )
  data_table.set_cell(4, 0, 'Luthsana'    )
  data_table.set_cell(4, 1, 2  )

  opts   = { :width => 500, :height => 350, :title => 'Cost by Airline' }
  @vendor_flight_cost_pie = GoogleVisualr::Interactive::PieChart.new(data_table, opts)

# FLIGHTS SCATTER
   data_table = GoogleVisualr::DataTable.new
  data_table.new_column('number', 'Age')
  data_table.new_column('number', 'Weight')
  data_table.add_rows(6)
  data_table.set_cell( 0, 0, 8  )
  data_table.set_cell( 0, 1, 12 )
  data_table.set_cell( 1, 0, 4  )
  data_table.set_cell( 1, 1, 5.5)
  data_table.set_cell( 2, 0, 11 )
  data_table.set_cell( 2, 1, 14 )
  data_table.set_cell( 3, 0, 4  )
  data_table.set_cell( 3, 1, 4.5)
  data_table.set_cell( 4, 0, 3  )
  data_table.set_cell( 4, 1, 3.5)
  data_table.set_cell( 5, 0, 6.5)
  data_table.set_cell( 5, 1, 7  )

  opts   = { :width => 400, :height => 240, :title => 'Days in Advance to Cost per Mile',
             :hAxis => { :title => 'Days in Advance'    , :minValue => 0, :maxValue => 15 },
             :vAxis => { :title => 'Cost Per Mile' , :minValue => 0, :maxValue => 15 },
             :legend => 'none' }
  @vendor_flight_scatter_chart = GoogleVisualr::Interactive::ScatterChart.new(data_table, opts)


  data_table = GoogleVisualr::DataTable.new
  data_table.new_column('string', 'Year')
  data_table.new_column('number', 'Sales')
  data_table.add_rows(4)
  data_table.set_cell(0, 0, '2004')
  data_table.set_cell(0, 1, 1000)
  data_table.set_cell(1, 0, '2005')
  data_table.set_cell(1, 1, 1170)
  data_table.set_cell(2, 0, '2006')
  data_table.set_cell(2, 1, 660)
  data_table.set_cell(3, 0, '2007')
  data_table.set_cell(3, 1, 1030)

  opts   = { :width => 400, :height => 240, :title => 'Company Performance', :hAxis => { :title => 'Year', :titleTextStyle => {:color => 'red'}} }
  @vendor_flight_barchart = GoogleVisualr::Interactive::ColumnChart.new(data_table, opts)



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
