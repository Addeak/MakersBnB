xfeature 'Dealing with bookings' do
  scenario 'A customer user with no requests, can see an empty list of requests' do
    register_user
    click_button 'My Requests'

    expect(page).to have_content 'You have no bookings'
  end

  xscenario 'A host can accept a requested booking' do
    register_user
    add_place
    register_user(first_name: 'Michael', surname: 'Jordan', email: 'mjordan@example.org')

    click_button 'Request Stay'
    
    fill_in 'check_in', with: '2022-4-4'
    fill_in 'check_out', with: '2022-4-7'
    click_button 'Submit'

    visit '/places/list'
    fill_in 'user_email', with: 'mjordan@example.org'
    fill_in 'user_password', with: 'password'
    click_button 'My Requests'

    expect(page).to have_content '????????????'
    expect(page).to have_content 'Status: Pending'
  end
end
