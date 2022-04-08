feature 'Adding a new place' do 
  scenario 'A user can add a new place' do 
    add_place

    expect(current_path).to eq('/places/list')
    expect(page).to have_content('Test Place')
    expect(page).to have_content('10.00')
    expect(page).to have_content('London')
    expect(page).to have_content('This is a place to stay in London')
  end

  scenario 'A user can specify availability dates' do
    add_place

    expect(current_path).to eq('/places/list')
    expect(page).to have_content('Test Place')
    expect(page).to have_content('10.00')
    expect(page).to have_content('London')
    expect(page).to have_content('This is a place to stay in London')
    expect(page).to have_content('2022-04-07')
    expect(page).to have_content('2022-04-30')
  end

end
