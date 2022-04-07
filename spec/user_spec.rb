require 'user'

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
      # expect(BCrypt::Password).to receive(:create).with('password1')
      persisted_data = PG.connect(dbname: "makersbnb_test").query("SELECT * FROM users WHERE id = #{user.id}")
      expect(user).to be_a User
      expect(user.user_first_name).to eq 'Jane'
      expect(user.user_surname).to eq 'Doe'
      expect(user.user_email).to eq 'janedoe@whatever.com'
      # expect(user.user_password).not_to eq 'password1'
      expect(user.mobile_number).to eq '07777000111'
    end

    it 'hashes the password using BCrypt' do
      expect(BCrypt::Password).to receive(:create).with('password1')
      user = User.create(
        user_first_name: 'Jane',
        user_surname: 'Doe',
        user_email: 'janedoe@whatever.com',
        user_password: 'password1',
        mobile_number: '07777000111'
      )
      expect(user.user_password).not_to eq 'password1'
    end
  end

  describe '.find' do
    it 'finds a user by ID' do
      user = User.create(
        user_first_name: 'Jane',
        user_surname: 'Doe',
        user_email: 'janedoe@whatever.com',
        user_password: 'password1',
        mobile_number: '07777000111'
      )

      # persisted_data = PG.connect(dbname: "makersbnb_test").query("SELECT * FROM users WHERE id = #{user.id}")
      result = User.find(id: user.id)
      expect(result.id).to eq user.id
      expect(result.user_email).to eq user.user_email
    end
  end
    describe '.find' do
      it 'returns nil if there is no ID given' do
        expect(User.find(id: nil)).to eq nil
    end
  end
end

