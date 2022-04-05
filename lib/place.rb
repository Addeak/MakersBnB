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
        description: place['description']
      )
    end
  end
end
