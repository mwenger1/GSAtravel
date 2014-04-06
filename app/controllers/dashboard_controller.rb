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

  def transactions_data
    respond_to do |format|
      format.html
      format.json{ render json: ReservationsDatatable.new(view_context)}
    # @flight_reservations = FlightReservation.find(:all, :order => "id desc", :limit => 300)
    end
  end

  def overview_data
    respond_to do |format|
      format.html
      format.json{ render json: ReservationsDatatable.new(view_context)}
    # @flight_reservations = FlightReservation.find(:all, :order => "id desc", :limit => 300)
    end
  end

  def budgets
  end

  def trends
  end

  def ways_to_save
  end

  private
  def set_date
    @date = Date.today.strftime('%b %d, %Y')
    @date_in_past = (Date.today-30).strftime('%b %d, %Y')

  end
end
