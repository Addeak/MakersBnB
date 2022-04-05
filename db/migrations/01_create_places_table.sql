CREATE TABLE places (
  id SERIAL PRIMARY KEY, 
  host_name VARCHAR(60), 
  host_email VARCHAR(255), 
  place_title VARCHAR(140), 
  place_price DECIMAL(10, 2), 
  location VARCHAR(60), 
  description VARCHAR(1000)
);