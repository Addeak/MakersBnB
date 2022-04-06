CREATE TABLE users (
  id SERIAL PRIMARY KEY, 
  user_first_name VARCHAR(60), 
  user_surname VARCHAR(60),
  user_email VARCHAR(255), 
  user_password VARCHAR(140),
  mobile_number VARCHAR(15)
);