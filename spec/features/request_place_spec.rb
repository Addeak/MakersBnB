feature 'Requesting a place' do
  scenario 'A customer can request a stay in one of the places' do
    add_place
    register_user

    click_button 'Request Stay'
    
    fill_in 'check_in', with: '2022-4-4'
    fill_in 'check_out', with: '2022-4-7'
    click_button 'Submit'

    visit('/users/myrequests')
    expect(page).to have_content('Test Place')
    expect(page).to have_content('Pending')
  end
end
