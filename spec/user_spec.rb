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
end

