class UserBooking

  attr_reader :booking_id, :place_id, :guest_id, :check_in_date, :check_out_date, :status, :place_title, :place_price, :location

  def initialize(booking_id:, place_id:, guest_id:, check_in_date:, check_out_date:, status:, place_title:, place_price:, location:)
    @booking_id = booking_id
    @place_id = place_id
    @guest_id = guest_id
    @check_in_date = check_in_date
    @check_out_date = check_out_date
    @status = status
    @place_title = place_title
    @place_price = place_price
    @location = location
  end

  def self.list(user_id:)
    result = DatabaseConnection.query(
      "SELECT bookings.id AS booking_id, places.id AS place_id, guest_id, check_in_date, check_out_date, status, place_title, place_price, location 
      FROM bookings 
      LEFT JOIN places ON place_id = places.id 
      WHERE guest_id = $1;", [user_id]
    )
    result.map do |booking|
      UserBooking.new(
        booking_id: booking['booking_id'],
        place_id: booking['place_id'],
        guest_id: booking['guest_id'],
        check_in_date: booking['check_in_date'],
        check_out_date: booking['check_out_date'],
        status: booking['status'],
        place_title: booking['place_title'],
        place_price: booking['place_price'],
        location: booking['location']
      )
    end
  end
end
