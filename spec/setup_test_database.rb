require 'pg'
require 'database_connection'

def clear_test_database
  DatabaseConnection.setup("makersbnb_test")
  DatabaseConnection.query("TRUNCATE places, bookings;")
end
