feature 'Adding a new place' do 
  scenario 'A user can add a new place' do 
    visit('/places/add')
    fill_in('place_title', with: 'Test Place')
    fill_in('place_price', with: '10.00') 
    fill_in('location', with: 'London')
    fill_in('description', with: 'This is a place to stay in London')
    click_button('Submit')

    expect(current_path).to eq('/places/list')
    expect(page).to have_content('Test Place')
    expect(page).to have_content('10.00')
    expect(page).to have_content('London')
    expect(page).to have_content('This is a place to stay in London')
  end
end