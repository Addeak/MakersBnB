require 'database_connection'

feature 'view the list of available places' do
  scenario 'a user can see a list of all places in the database' do
    DatabaseConnection.query(
      "INSERT INTO places (
        host_name,
        host_email,
        place_title,
        place_price,
        location,
        description
      )
    VALUES (
      'Bilbo Baggins',
      'bilbo@example.org',
      'Bag End - cosy cottage in rural location',
      '75',
      'The Shire',
      'A beautifully kept underground cottage. Book early for best price.')"
    )

    DatabaseConnection.query(
      "INSERT INTO places (
        host_name,
        host_email,
        place_title,
        place_price,
        location,
        description
      )
    VALUES (
      'Darth Vader',
      'vader@example.org',
      'Death Star - top-tier space station',
      '5000',
      'Death Star',
      'The ultimate weapon for the Empire. Book now for the best price.')"
    )

    visit('/')

    expect(page).to have_content('Bilbo Baggins')
    expect(page).to have_content('Bag End - cosy cottage in rural location')
    expect(page).to have_content('£75 per night')
    expect(page).to have_content('Darth Vader')
    expect(page).to have_content('Death Star - top-tier space station')
    expect(page).to have_content('£5000 per night')
  end
end
