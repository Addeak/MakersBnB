class Booking

  attr_reader :id, :guest_id, :place_id, :check_in_date, :check_out_date, :status

  def initialize(id:, guest_id:, place_id:, check_in_date:, check_out_date:, status:)
    @id = id
    @guest_id = guest_id
    @place_id = place_id
    @check_in_date = check_in_date
    @check_out_date = check_out_date
    @status = status
  end
 
  def self.create(guest_id:, place_id:, check_in_date:, check_out_date:)
   result = DatabaseConnection.query("INSERT INTO bookings (
    guest_id, place_id, check_in_date, check_out_date)
    VALUES ($1, $2, $3, $4)
    RETURNING id, guest_id, place_id, check_in_date, check_out_date, status;",
    [guest_id, place_id, check_in_date, check_out_date])

    Booking.new(
      id: result[0]['id'],
      guest_id: result[0]['guest_id'],
      place_id: result[0]['place_id'],
      check_in_date: result[0]['check_in_date'],
      check_out_date: result[0]['check_out_date'],
      status: result[0]['status']
    )
  end

  def accept
    result = DatabaseConnection.query("UPDATE bookings SET status = 'Accepted' WHERE id = $1 RETURNING status;", [@id])
    @status = result[0]['status']
  end

  def decline
    result = DatabaseConnection.query("UPDATE bookings SET status = 'Declined' WHERE id = $1 RETURNING status;", [@id])
    @status = result[0]['status']
  end
end
