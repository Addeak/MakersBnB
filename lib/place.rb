require './lib/database_connection'

class Place
  attr_reader :id, :host_name, :host_email, :place_title, :place_price, :location, :description
  def initialize(id:, host_name:, host_email:, place_title:, place_price:, location:, description:)
    @id = id
    @host_name = host_name
    @host_email = host_email
    @place_title = place_title
    @place_price = place_price
    @location = location
    @description = description
  end

  def self.create(host_name:, host_email:, place_title:, place_price:, location:, description:)
    result = DatabaseConnection.query(
      "INSERT INTO places (host_name, host_email, place_title, place_price, location, description)
      VALUES($1, $2, $3, $4, $5, $6)
      RETURNING id, host_name, host_email, place_title, place_price, location, description;",
      [host_name, host_email, place_title, place_price, location, description]
      )
    Place.new(
      id: result[0]['id'],
      host_name: result[0]['host_name'],
      host_email: result[0]['host_email'],
      place_title: result[0]['place_title'],
      place_price: result[0]['place_price'],
      location: result[0]['location'],
      description: result[0]['description']
      )
  end
  
end
