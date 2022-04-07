def create_place
  DatabaseConnection.query(
    "INSERT INTO places (host_name, host_email, place_title, place_price, location, description, available_from, available_until)
    VALUES($1, $2, $3, $4, $5, $6, $7, $8)
    RETURNING id;", ['John', 'john@example.org', 'The house', '100', 'London', 'A great house', '2019-01-01', '2023-01-02']
  )
end

def create_user
  DatabaseConnection.query(
    "INSERT INTO users (user_first_name, user_surname, user_email, user_password, mobile_number)
    VALUES($1, $2, $3, $4, $5)
    RETURNING id;", ['Guest', 'Guestsson', 'guest@example.org', 'password', '07123456789']
  )
end
