require 'bcrypt'
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
    encrypted_password = BCrypt::Password.create(user_password)
    result = DatabaseConnection.query(
      "INSERT INTO users (user_first_name, user_surname, user_email, user_password, mobile_number)
      VALUES($1, $2, $3, $4, $5)
      RETURNING id, user_first_name, user_surname, user_email, user_password, mobile_number;",
      [user_first_name, user_surname, user_email, encrypted_password, mobile_number]
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

  def self.find(id:)
    return nil unless id
    result = DatabaseConnection.query("SELECT * FROM users WHERE id = $1", [id])
    User.new(
      id: result[0]['id'], 
      user_first_name: result[0]['user_first_name'],
      user_surname: result[0]['user_surname'],
      user_email: result[0]['user_email'],
      user_password: result[0]['user_password'],
      mobile_number: result[0]['mobile_number']
    )
  end
end