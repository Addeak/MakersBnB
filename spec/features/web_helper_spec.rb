def register_user 
  visit("/users/register")
  fill_in("First name", with: "Jon")
  fill_in("Surname", with: "Doe")
  fill_in("Email", with: "jondoe@whatever.com")
  fill_in("Password", with: "password")
  fill_in("Confirm password", with: "password")
  fill_in("Phone number", with: "07123456789")
  click_button("Submit")
end

def add_place
  visit('/places/add')
  fill_in('place_title', with: 'Test Place')
  fill_in('place_price', with: '10.00') 
  fill_in('location', with: 'London')
  fill_in('description', with: 'This is a place to stay in London')
  fill_in('available_from', with: '2022-04-07')
  fill_in('available_until', with: '2022-04-30')
  click_button('Submit')
end