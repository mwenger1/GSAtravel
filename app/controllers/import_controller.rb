class ImportController < ApplicationController
  def index
    @flight_transactions = FlightReservation.all.count
    @hotel_transactions = HotelReservation.all.count

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
                f = HotelReservation.new
                f.gds_record_locator = entry[0]
                f.reservation_date = Date.strptime(entry[1], '%m/%d/%y') unless entry[1].nil?
                f.check_in_date = Date.strptime(entry[2], '%m/%d/%y') unless entry[2].nil?
                f.check_out_date = Date.strptime(entry[3], '%m/%d/%y') unless entry[3].nil?
                f.hotel_chain_code = entry[4]
                f.hotel_chain_name = entry[5]
                f.hotel_property_name = entry[6]
                f.hotel_address = entry[7]
                f.hotel_city_name = entry[8]
                f.hotel_state = entry[9]
                f.hotel_zip_code = entry[10]
                f.hotel_country_code = entry[11]
                f.number_of_room_nights = entry[12].to_i
                f.daily_rate = entry[13].to_f
                f.room_rate_code = calculate_benchmark_rate(entry[13])
                f.save
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
    redirect_to import_index_path, notice: "File successfully imported"
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
    redirect_to import_index_path, notice: "File successfully imported"
  end

  def delete_all
    FlightReservation.delete_all
    redirect_to import_index_path, notice: "All Items deleted"
  end
end
