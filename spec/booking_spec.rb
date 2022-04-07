require 'booking'
require './spec/database_helper'

describe Booking do
  describe '.create' do
    it 'creates a new booking' do
      places_result = create_place
      user_result = create_user

      user = double :user, id: user_result[0]['id']
      place = double :place, id: places_result[0]['id']

      booking = Booking.create(guest_id: user.id, place_id: place.id, check_in_date: '2022-06-08', check_out_date: '2022-06-15')
      persisted_data = DatabaseConnection.query("SELECT * FROM bookings WHERE id = #{booking.id}")

      expect(booking.id).to eq persisted_data.first['id']
      expect(booking.place_id).to eq(place.id)
      expect(booking.guest_id).to eq(user.id)
      expect(booking.check_in_date).to eq('2022-06-08')
      expect(booking.check_out_date).to eq('2022-06-15')
      expect(booking.status).to eq 'Pending'
    end
  end

  describe '#accept' do
    it 'accepts a booking' do
      places_result = create_place
      user_result = create_user
      user = double :user, id: user_result[0]['id']
      place = double :place, id: places_result[0]['id']
      booking = Booking.create(guest_id: user.id, place_id: place.id, check_in_date: '2022-06-08', check_out_date: '2022-06-15')

      booking.accept

      expect(booking.status).to eq 'Accepted'
    end
  end
  
  describe '#decline' do
    it 'declines a booking' do
      places_result = create_place
      user_result = create_user
      user = double :user, id: user_result[0]['id']
      place = double :place, id: places_result[0]['id']
      booking = Booking.create(guest_id: user.id, place_id: place.id, check_in_date: '2022-06-08', check_out_date: '2022-06-15')

      booking.decline

      expect(booking.status).to eq 'Declined'
    end
  end
end
