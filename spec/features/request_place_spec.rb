feature 'Requesting a place' do
  scenario 'A customer can request a stay in one of the places' do
    result = DatabaseConnection.query(
      "INSERT INTO places (host_name, host_email, place_title, place_price, location, description) 
      VALUES ('Moneybags', 'moneybags@example.com', 'Luxurious Villa', 500.00, 'London', 'Fantastic place. Must see!') RETURNING id;")
    place_id = result[0]['id']
    visit "/places/#{place_id}/request"
    fill_in 'customer_name', with: 'Adam'
    fill_in 'customer_email', with: 'customer@example.com'
    fill_in 'check_in', with: '2022-4-4'
    fill_in 'check_out', with: '2022-4-7'
    fill_in 'comments_box', with: 'Example comments'
    click_button 'Submit'

    expect(current_path).to eq "/places/#{place_id}/confirmation"
    expect(page).to have_content 'Adam, your request has been successfully submitted.'
  end
end
