class ImportController < ApplicationController
  def index
    @flight_reservations = FlightReservation.all.count
  end

  def show
  end

  def run
    require 'csv'
    csv = File.read("#{Rails.public_path}/flight_reservation1_trimmed.csv")
    encoded_csv = csv.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
    parsed_csv = CSV.parse(encoded_csv)

    counter = 0
    parsed_csv.each do |entry|
        if counter != 0
            f = FlightReservation.new
            f.GDS_Record_Locator = entry[0]
            f.Reservation_Date = Date.strptime(entry[1], '%m/%d/%Y') unless entry[1].nil?
            f.Ticket_Issue_Date = Date.strptime(entry[2], '%m/%d/%Y') unless entry[2].nil?
            f.Trip_Departure_Date = Date.strptime(entry[3], '%m/%d/%Y') unless entry[3].nil?
            f.Ticket_Number = entry[4]
            f.Airline_Name = entry[5]
            f.Cabin_Class = entry[6]
            f.Domestic_International_Indicator = entry[7]
            f.Origin_Airport_Code = entry[8]
            f.Destination_Airport_Code = entry[9]
            f.Routing = entry[10]
            f.Invoice_Amount = entry[11].to_f
            f.Tax_Amount = entry[12].to_f
            f.Total_Amount = entry[13].to_f
            f.Mileage = entry[14].to_f
            f.Exchange_Indicator = entry[15]
            f.Exchange_Original_Ticket_Number = entry[16]
            f.Refund__Indicator = entry[17]
            f.Original_Invoice_Number = entry[18]
            f.Online_Indicator = entry[19]
            f.Fare_Category = entry[20]
            f.save
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
