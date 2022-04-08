require 'user_booking'
require 'database_helper'

describe UserBooking do 
  describe '.list' do
    it 'returns a list of booking requests by a user' do
      user1 = create_user

      user2 = create_user(user_first_name: 'Homer', user_surname: 'Simpson')

      place_result = create_place

      booking_result = create_booking(user_id: user1[0]['id'], place_id: place_result[0]['id'])

      booking_object = double :booking, id: booking_result[0]['id'],
                                        guest_id: booking_result[0]['guest_id'],
                                        place_id: booking_result[0]['place_id'],
                                        check_in_date: booking_result[0]['check_in_date'],
                                        check_out_date: booking_result[0]['check_out_date'],
                                        status: booking_result[0]['status']

      # expect(user2._bookings).to eq []
      expect(UserBooking.list(user_id: user1[0]['id']).first.booking_id).to eq booking_object.id
      expect(UserBooking.list(user_id: user1[0]['id']).first.guest_id).to eq booking_object.guest_id
      expect(UserBooking.list(user_id: user1[0]['id']).first.place_id).to eq booking_object.place_id
      expect(UserBooking.list(user_id: user1[0]['id']).first.check_in_date).to eq '2022-08-01'
      expect(UserBooking.list(user_id: user1[0]['id']).first.check_out_date).to eq '2022-08-09'
      expect(UserBooking.list(user_id: user1[0]['id']).first.status).to eq 'Pending'
    end
  end
end