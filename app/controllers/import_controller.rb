class ImportController < ApplicationController
  def index
    @flight_transactions = FlightReservation.all.count
    @hotel_transactions = HotelReservation.all.count
    @car_rental_transactions = CarRentalReservation.all.count

  end

  def show
  end

  def run_hotel
    require 'csv'
    if params[:length] =="short"
        csv = File.read("#{Rails.public_path}/hotel_reservation_trimmed.csv")
    else
        csv = File.read("#{Rails.public_path}/hotel_reservation.csv")
    end
    encoded_csv = csv.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
    parsed_csv = CSV.parse(encoded_csv)

    def calculate_benchmark_rate rate
        rate.to_f + rand(-50..400)
    end

    counter = 0
    parsed_csv.each do |entry|
        if counter != 0

            ## FILTERS OUT RETURNS AND REFUNDS @TODO incorporate refunds
            unless (false) ## ADD FILTERS
                h = HotelReservation.new
                h.gds_record_locator = entry[0]
                h.reservation_date = Date.strptime(entry[1], '%m/%d/%y') unless entry[1].nil?
                h.check_in_date = Date.strptime(entry[2], '%m/%d/%y') unless entry[2].nil?
                h.check_out_date = Date.strptime(entry[3], '%m/%d/%y') unless entry[3].nil?
                h.hotel_chain_code = entry[4]
                h.hotel_chain_name = entry[5]
                h.hotel_property_name = entry[6]
                h.hotel_address = entry[7]
                h.hotel_city_name = entry[8]
                h.hotel_state = entry[9]
                h.hotel_zip_code = entry[10]
                h.hotel_country_code = entry[11]
                h.number_of_room_nights = entry[12].to_i
                h.daily_rate = entry[13].to_f
                h.room_rate_code = calculate_benchmark_rate(entry[13])
                h.save
           end
        end
        counter = counter + 1
    end
    redirect_to import_index_path, notice: "Hotel file successfully imported"
  end

  def run_car_rental
    require 'csv'
    if params[:length] =="short"
        csv = File.read("#{Rails.public_path}/car_reservation_trimmed.csv")
    else
        csv = File.read("#{Rails.public_path}/car_reservation1.csv")
    end
    encoded_csv = csv.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
    parsed_csv = CSV.parse(encoded_csv)

    def calculate_benchmark_rate rate
        rate.to_f + rand(-50..400)
    end

    counter = 0
    parsed_csv.each do |entry|
        if counter != 0

            ## FILTERS OUT RETURNS AND REFUNDS @TODO incorporate refunds
            unless (entry[17] == "Y" || entry[17] == "P" || entry[15] == "Y" || entry[13].blank? || entry[4].blank? || entry[3].blank?)
                c = CarRentalReservation.new
                c.gds_record_locator = entry[0]
                c.reservation_date = Date.strptime(entry[1], '%m/%d/%y') unless entry[1].nil?
                c.car_pick_up_date = Date.strptime(entry[2], '%m/%d/%y') unless entry[2].nil?
                c.car_drop_off_date = Date.strptime(entry[3], '%m/%d/%y') unless entry[3].nil?
                c.car_chain_code = entry[4]
                c.car_chain_name = entry[5]
                c.car_pick_up_city = entry[6]
                c.car_pick_up_state = entry[7]
                c.car_drop_off_city = entry[8]
                c.car_drop_off_state = entry[9]
                c.car_rental_days = entry[10].to_i
                c.car_daily_rate = entry[11].to_f
                c.benchmark_rate = calculate_benchmark_rate(entry[13])
                c.car_category = entry[12]
                c.online_indicator = entry[13]
                c.save
           end
        end
        counter = counter + 1
    end

    redirect_to import_index_path, notice: "Car file successfully imported"
  end


  def run_airline
    require 'csv'
    if params[:length] =="short"
        csv = File.read("#{Rails.public_path}/flight_reservation1_small.csv")
    else
        csv = File.read("#{Rails.public_path}/flight_reservation1.csv")
    end

    encoded_csv = csv.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
    parsed_csv = CSV.parse(encoded_csv)

    def calculate_benchmark_rate rate
        rate.to_f + rand(-50..400)
    end

    counter = 0
    parsed_csv.each do |entry|
        if counter != 0

            ## FILTERS OUT RETURNS AND REFUNDS @TODO incorporate refunds
            unless (entry[17] == "Y" || entry[17] == "P" || entry[15] == "Y" || entry[13].blank? || entry[4].blank? || entry[3].blank?)
                f = FlightReservation.new
                f.gds_record_locator = entry[0]
                f.reservation_date = Date.strptime(entry[1], '%m/%d/%y') unless entry[1].nil?
                f.ticket_issue_date = Date.strptime(entry[2], '%m/%d/%y') unless entry[2].nil?
                f.trip_departure_date = Date.strptime(entry[3], '%m/%d/%y') unless entry[3].nil?
                f.ticket_number = entry[4]
                f.airline_name = entry[5]
                f.cabin_class = entry[6]
                f.domestic_international_indicator = entry[7]
                f.origin_airport_code = entry[8]
                f.destination_airport_code = entry[9]
                f.routing = entry[10]
                f.invoice_amount = entry[11].to_f
                f.tax_amount = entry[12].to_f
                f.total_amount = entry[13].to_f
                f.benchmark_rate = calculate_benchmark_rate(entry[13])
                f.mileage = entry[14].to_f.round(1)
                f.exchange_indicator = entry[15]
                f.exchange_original_ticket_number = entry[16]
                f.refund_indicator = entry[17]
                f.original_invoice_number = entry[18]
                f.online_indicator = entry[19]
                f.fare_category = entry[20]
                f.save
           end
        end
        counter = counter + 1
    end
    redirect_to import_index_path, notice: "Airline file successfully imported"
  end

  def delete_all
    FlightReservation.delete_all
    HotelReservation.delete_all
    CarRentalReservation.delete_all
    redirect_to import_index_path, notice: "All Items deleted"
  end
end
