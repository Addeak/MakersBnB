feature 'Dealing with bookings' do
  scenario 'A customer user with no requests, can see an empty list of requests' do
    register_user
    visit '/users/myrequests'

    expect(page).to have_content 'You have no bookings'
  end

  scenario 'A host can accept a requested booking' do
    register_user # first_name: 'Jon', surname: 'Doe', email: 'jondoe@example.org'
    add_place # 'Test Place'
    click_button 'Log-out'
    register_user(first_name: 'Michael', surname: 'Jordan', email: 'mjordan@example.org')
    
    click_button 'Request Stay'
    
    fill_in 'check_in', with: '2022-4-4'
    fill_in 'check_out', with: '2022-4-7'
    click_button 'Submit'

    click_button 'Log-out'

    visit '/places/list'
    fill_in 'user_email', with: 'mjordan@example.org'
    fill_in 'user_password', with: 'password'
    click_button 'Log-in'
    visit '/users/myrequests'
   
    expect(page).to have_content 'Test Place'
    expect(page).to have_content 'Status: Pending'
    # expect(page).to have_button 'Accept'
    # expect(page).to have_button 'Decline'
  end
end
