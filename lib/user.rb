class User
  attr_reader :id, :user_first_name, :user_surname, :user_email, :user_password, :mobile_number

  def initialize(id:, user_first_name:, user_surname:, user_email:, user_password:, mobile_number:)
    @id = id
    @user_first_name = user_first_name
    @user_surname = user_surname
    @user_email = user_email
    @user_password = user_password
    @mobile_number =mobile_number
  end

  def self.create(user_first_name:, user_surname:, user_email:, user_password:, mobile_number:)
    result = DatabaseConnection.query(
      "INSERT INTO users (user_first_name, user_surname, user_email, user_password, mobile_number)
      VALUES($1, $2, $3, $4, $5)
      RETURNING id, user_first_name, user_surname, user_email, user_password, mobile_number;",
      [user_first_name, user_surname, user_email, user_password, mobile_number]
      )
    User.new(
      id: result[0]['id'],
      user_first_name: result[0]['user_first_name'],
      user_surname: result[0]['user_surname'],
      user_email: result[0]['user_email'],
      user_password: result[0]['user_password'],
      mobile_number: result[0]['mobile_number'],
      )
  end

  def list_bookings
    result = DatabaseConnection.query("SELECT bookings.id, places.id AS place_id_real FROM bookings LEFT JOIN places ON place_id = places.id WHERE guest_id = $1;", [@id])
    binding.irb
    # this needs to be completed
    # create Bookinglist class?
    # or pull out the two id numbers and use Booking, Place classes to list info that we want
  end
end