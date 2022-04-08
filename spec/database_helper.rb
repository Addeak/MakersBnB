def create_place
  DatabaseConnection.query(
    "INSERT INTO places (host_name, host_email, place_title, place_price, location, description, available_from, available_until)
    VALUES($1, $2, $3, $4, $5, $6, $7, $8)
    RETURNING id;", ['John', 'john@example.org', 'The house', '100', 'London', 'A great house', '2019-01-01', '2023-01-02']
  )
end

def create_user(user_first_name: 'Guest', user_surname: 'Guestsson')
  DatabaseConnection.query(
    "INSERT INTO users (user_first_name, user_surname, user_email, user_password, mobile_number)
    VALUES($1, $2, $3, $4, $5)
    RETURNING id;", [user_first_name, user_surname, 'guest@example.org', 'password', '07123456789']
  )
end

def create_booking(user_id:, place_id:)
  DatabaseConnection.query(
    "INSERT INTO bookings (guest_id, place_id, check_in_date, check_out_date)
    VALUES($1, $2, $3, $4)
    RETURNING id, guest_id, place_id, check_in_date, check_out_date, status;", [user_id, place_id, '2022-08-01', '2022-08-09']
  )
end
