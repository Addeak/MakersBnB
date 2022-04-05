1-implement-a-request-feature
require './lib/database_connection'
main

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
  
end
