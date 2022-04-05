feature 'Adding a new place' do 
  xscenario 'A user can add a new place' do 
    visit('/places/add')
    fill_in('host_name', with: 'Bob Smith')
    fill_in('host_email', with: 'bobsmith@testmail.com')
    fill_in('place_title', with: 'Test Place')
    fill_in('place_price', with: '10.00') 
    fill_in('location', with: 'London')
    fill_in('description', with: 'This is a place to stay in London')
    click_button('Submit')

    expect(current_path).to eq('/places')
    expect(page).to have_content('Bob Smith')
    expect(page).to have_content('bobsmith@testmail.com')
    expect(page).to have_content('Test Place')
    expect(page).to have_content('10.00')
    expect(page).to have_content('London')
    expect(page).to have_content('This is a place to stay in London')
  end
end