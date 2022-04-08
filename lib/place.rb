require './lib/database_connection'

class Place 
  attr_reader :id, :host_name, :host_email, :place_title, :place_price, :location, :description, :available_from, :available_until

  def initialize(id:, host_name:, host_email:, place_title:, place_price:, location:, description:, available_from:, available_until:)
    @id = id
    @host_name = host_name
    @host_email = host_email
    @place_title = place_title
    @place_price = place_price
    @location = location
    @description = description
    @available_from = available_from
    @available_until = available_until
  end

  def self.all
    results = DatabaseConnection.query("SELECT * FROM places")
    results.map do |place|
      Place.new(
        id: place['id'],
        host_name: place['host_name'],
        host_email: place['host_email'],
        place_title: place['place_title'],
        place_price: place['place_price'],
        location: place['location'],
        description: place['description'],
        available_from: place['available_from'],
        available_until: place['available_until']
      )
    end
  end

  def self.create(host_name:, host_email:, place_title:, place_price:, location:, description:, available_from:, available_until:)
    result = DatabaseConnection.query(
      "INSERT INTO places (host_name, host_email, place_title, place_price, location, description, available_from, available_until)
      VALUES($1, $2, $3, $4, $5, $6, $7, $8)
      RETURNING id, host_name, host_email, place_title, place_price, location, description, available_from, available_until;",
      [host_name, host_email, place_title, place_price, location, description, available_from, available_until]
      )
    Place.new(
      id: result[0]['id'],
      host_name: result[0]['host_name'],
      host_email: result[0]['host_email'],
      place_title: result[0]['place_title'],
      place_price: result[0]['place_price'],
      location: result[0]['location'],
      description: result[0]['description'],
      available_from: result[0]['available_from'],
      available_until: result[0]['available_until']
      )
  end
  
  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM places WHERE id = $1;", [id])
    Place.new(
      id: result[0]['id'], 
      host_name: result[0]['host_name'], 
      host_email: result[0]['host_email'], 
      place_title: result[0]['place_title'], 
      place_price: result[0]['place_price'], 
      location: result[0]['location'], 
      description: result[0]['description'],
      available_from: result[0]['available_from'],
      available_until: result[0]['available_until']
    )
  end
end
