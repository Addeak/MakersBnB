require 'booking'

describe Booking do
  describe '.create' do
    it 'creates a new booking' do
      places_result = DatabaseConnection.query("INSERT INTO places (host_name, host_email, place_title, place_price, location, description, available_from, available_until)
      VALUES($1, $2, $3, $4, $5, $6, $7, $8)
      RETURNING id;", ['John', 'john@example.org', 'The house', '100', 'London', 'A great house', '2019-01-01', '2023-01-02'])

      user_result = DatabaseConnection.query("INSERT INTO users (user_first_name, user_surname, user_email, user_password, mobile_number)
      VALUES($1, $2, $3, $4, $5)
      RETURNING id;", ['Guest', 'Guestsson', 'guest@example.org', 'password', '07123456789'])

      user = double :user, id: user_result[0]['id']
      place = double :place, id: places_result[0]['id']


      booking = Booking.create(guest_id: user.id, place_id: place.id, check_in_date: '2022-06-08', check_out_date: '2022-06-15')
      
      persisted_data = DatabaseConnection.query("SELECT * FROM bookings WHERE id = #{booking.id}")

      expect(booking.id).to eq persisted_data.first['id']
      expect(booking.place_id).to eq(place.id)
      expect(booking.guest_id).to eq(user.id)
      expect(booking.check_in_date).to eq('2022-06-08')
      expect(booking.check_out_date).to eq('2022-06-15')
    end
  end
end
