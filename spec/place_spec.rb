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
        description: 'This is a place to stay in London',
        available_from: '2022-04-07',
        available_until: '2022-04-30'
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
      expect(place.available_from).to eq '2022-04-07'
      expect(place.available_until).to eq '2022-04-30'
    end
  end

  describe '::all' do 
    it 'returns all places' do 
      place_1 = Place.create(
        host_name: 'Bob Smith',
        host_email: 'bobsmith@testmail.com',
        place_title: 'Test Place',
        place_price: '10.00',
        location: 'London',
        description: 'This is a place to stay in London',
        available_from: '2022-04-07',
        available_until: '2022-04-30',
      )

      place_2 = Place.create(
        host_name: 'Kathy Jones',
        host_email: 'kathyjones@testmail.com',
        place_title: 'Test Place 2',
        place_price: '20.00',
        location: 'Folkestone',
        description: 'By the seaside',
        available_from: '2022-04-09',
        available_until: '2022-04-28'
      )

      places = Place.all

      expect(places.length).to eq 2
      expect(places.first).to be_a Place
      expect(places.first.id).to eq place_1.id
      expect(places.first.place_title).to eq 'Test Place'
      expect(places.first.place_price). to eq '10.00'
      expect(places.first.location).to eq 'London'
      expect(places.first.description).to eq 'This is a place to stay in London'
      expect(places.first.available_from).to eq '2022-04-07'
      expect(places.first.available_until).to eq '2022-04-30'
    end
  end

  describe '::find' do 
    it 'returns request place' do 
      place = Place.create(
        host_name: 'Bob Smith',
        host_email: 'bobsmith@testmail.com',
        place_title: 'Test Place',
        place_price: '10.00',
        location: 'London',
        description: 'This is a place to stay in London',
        available_from: '2022-04-09',
        available_until: '2022-04-28'
      )

      result = Place.find(id: place.id)

      expect(result).to be_a Place
      expect(result.id).to eq place.id
      expect(result.place_title).to eq 'Test Place'
      expect(result.place_price). to eq '10.00'
      expect(result.location).to eq 'London'
      expect(result.description).to eq 'This is a place to stay in London'
      expect(result.available_from).to eq '2022-04-09'
      expect(result.available_until).to eq '2022-04-28'
    end
  end
end
