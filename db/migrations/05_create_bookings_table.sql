CREATE TABLE bookings (
  id SERIAL PRIMARY KEY,
  place_id INTEGER NOT NULL REFERENCES places (id),
  guest_id INTEGER NOT NULL REFERENCES users (id),
  check_in_date DATE NOT NULL,
  check_out_date DATE NOT NULL,
  booking_status VARCHAR(60) DEFAULT 'Pending'
  );
