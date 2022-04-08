feature 'user_authentication' do
  scenario 'user signs in & sees name on the home page' do
    user = User.create(
        user_first_name: 'Jane',
        user_surname: 'Doe',
        user_email: 'janedoe@whatever.com',
        user_password: 'password1',
        mobile_number: '07777000111'
      )
    visit('/')
    fill_in('user_email', with: 'janedoe@whatever.com')
    fill_in('user_password', with: 'password1')

    click_button('Login')

    expect(page).to have_content('Welcome, janedoe@whatever.com')
  end

  xscenario 'wrong user name throws error' do
    visit('/')

    fill_in('user_name', with: 'dfgsdfgf gfhs')
    fill_in('password', with: 'password')

    click_button('Login')

    expect(page).to have_content('Invalid User Name!')
  end

  xscenario 'wrong user name throws error' do
    visit('/')
    
    fill_in('user_name', with: 'John Doe')
    fill_in('password', with: 'fdgsfg')

    click_button('Login')

    expect(page).to have_content('Invalid password!')
  end
end
