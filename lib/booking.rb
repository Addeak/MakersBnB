class Booking

  attr_reader :id, :guest_id, :place_id, :check_in_date, :check_out_date, :booking_status

  def initialize(id:, guest_id:, place_id:, check_in_date:, check_out_date:, booking_status:)
    @id = id
    @guest_id = guest_id
    @place_id = place_id
    @check_in_date = check_in_date
    @check_out_date = check_out_date
    @booking_status = booking_status
  end
 
  def self.create(guest_id:, place_id:, check_in_date:, check_out_date:)
   result = DatabaseConnection.query("INSERT INTO bookings (
    guest_id, place_id, check_in_date, check_out_date)
    VALUES ($1, $2, $3, $4)
    RETURNING id, guest_id, place_id, check_in_date, check_out_date, booking_status;",
    [guest_id, place_id, check_in_date, check_out_date])

    Booking.new(
      id: result[0]['id'],
      guest_id: result[0]['guest_id'],
      place_id: result[0]['place_id'],
      check_in_date: result[0]['check_in_date'],
      check_out_date: result[0]['check_out_date'],
      booking_status: result[0]['booking_status']
    )
  end
end