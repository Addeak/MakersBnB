require 'place'

describe Place do

  describe '::create' do
    it 'creates a new place' do
      place = Place.create(
        host_name: 'Bob Smith',
        host_email: 'bobsmith@testmail.com',
        place_title: 'Test Place',
        place_price: '10.00',
        location: 'London',
        description: 'This is a place to stay in London'
      )

      persisted_data = PG.connect(dbname: "makersbnb_test").query("SELECT * FROM places WHERE id = #{place.id}")
      expect(place).to be_a Place
      expect(place.id).to eq persisted_data.first['id']
      expect(place.host_name).to eq 'Bob Smith'
      expect(place.host_email).to eq 'bobsmith@testmail.com'
      expect(place.place_title).to eq 'Test Place'
      expect(place.place_price).to eq '10.00'
      expect(place.location).to eq 'London'
      expect(place.description).to eq 'This is a place to stay in London'
    end
  end
end
