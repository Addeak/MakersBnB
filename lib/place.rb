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
  
  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM places WHERE id = $1;", [id])
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
