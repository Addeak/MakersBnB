require 'user'
require 'database_helper'

describe User do
  describe '.create' do
    it 'creates a new user' do
      user = User.create(
        user_first_name: 'Jane',
        user_surname: 'Doe',
        user_email: 'janedoe@whatever.com',
        user_password: 'password1',
        mobile_number: '07777000111'
      )

      persisted_data = PG.connect(dbname: "makersbnb_test").query("SELECT * FROM users WHERE id = #{user.id}")
      expect(user).to be_a User
      expect(user.user_first_name).to eq 'Jane'
      expect(user.user_surname).to eq 'Doe'
      expect(user.user_email).to eq 'janedoe@whatever.com'
      expect(user.user_password).to eq 'password1'
      expect(user.mobile_number).to eq '07777000111'
    end
  end

  describe '#list_bookings' do
    it 'returns a list of all booking requests by a user' do
      user1 = User.create(
        user_first_name: 'Jane',
        user_surname: 'Doe',
        user_email: 'janedoe@example.org',
        user_password: 'password1',
        mobile_number: '07777000111'
      )

      user2 = User.create(
        user_first_name: 'Guesta',
        user_surname: 'Guestdottir',
        user_email: 'janedoe@example.org',
        user_password: 'password1',
        mobile_number: '07777000111'
      )

      place_result = create_place

      booking_result = create_booking(user_id: user1.id, place_id: place_result[0]['id'])

      booking_object = double :booking, id: booking_result[0]['id'],
                                        guest_id: booking_result[0]['guest_id'],
                                        place_id: booking_result[0]['place_id'],
                                        check_in_date: booking_result[0]['check_in_date'],
                                        check_out_date: booking_result[0]['check_out_date'],
                                        status: booking_result[0]['status']

      # expect(user2.list_bookings).to eq []
      expect(user1.list_bookings.first.id).to eq booking_object.id
      expect(user1.list_bookings.first.guest_id).to eq booking_object.guest_id
      expect(user1.list_bookings.first.place_id).to eq booking_object.place_id
      expect(user1.list_bookings.first.check_in_date).to eq '2022-08-01'
      expect(user1.list_bookings.first.check_out_date).to eq '2022-08-09'
      expect(user1.list_bookings.first.status).to eq 'Pending'
    end
  end
end

