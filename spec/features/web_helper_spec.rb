
def register_user(first_name: 'Jon', surname: 'Doe', email: 'jondoe@example.org') 

  visit("/users/register")
  fill_in("First name", with: first_name)
  fill_in("Surname", with: surname)
  fill_in("Email", with: email)
  fill_in("Password", with: "password")
  fill_in("Confirm password", with: "password")
  fill_in("Phone number", with: "07123456789")
  click_button("Submit")
end

def add_place(title: 'Test Place', price: '10.00')
  visit('/places/add')
  fill_in('place_title', with: title)
  fill_in('place_price', with: price) 
  fill_in('location', with: 'London')
  fill_in('description', with: 'This is a place to stay in London')
  fill_in('available_from', with: '2022-04-07')
  fill_in('available_until', with: '2022-04-30')
  click_button('Submit')
end
