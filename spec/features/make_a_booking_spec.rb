feature 'Making a booking' do
  scenario 'A customer user with no requests, can see an empty list of requests' do
    visit '/'
    click_button 'My Requests'

    expect(page).to have_content 'You have no bookings'
  end

  scenario 'A customer user with a request, can see their request' do
    user = DatabaseConnection.query(
      "INSERT INTO users (user_first_name, user_surname, user_email, user_password, mobile_number)
      VALUES ($1, $2, $3, $4, $5)
      RETURNING user_first_name, user_surname, user_email, user_password, mobile_number;",
      ['Joe', 'Blogs', 'joe@example.org', 'password', '0928']
    )
    place = Place.create(host_name: 'Jon', host_email: 'jon@example.org', place_title: 'Tent in my garden', place_price: '5.50', location: 'middle of nowhere', description: "Don't mind the builders", available_from: '2022-04-07', available_until: '2022-05-07')
    visit '/'
    fill_in 'username', with: 'joe@example.org'
    fill_in 'password', with: 'password'
    click_button 'Log in'
    click_button('Request Stay', :match => :first)

    expect(current_path).to eq "/places/#{place.id}/requests"
    fill_in 'customer_name', with: 'Joe Blogs'
    fill_in 'customer_email', with: 'joe@example.org'
    fill_in 'check_in', with: '2022-4-8'
    fill_in 'check_out', with: '2022-4-10'
    fill_in 'comments_box', with: 'Love builders I do!'
    click_button 'Submit'
    click_button 'My Requests'

    expect(page).to have_content "#{place.place_title}"
    expect(page).to have_content 'Status: Pending'
  end
end
