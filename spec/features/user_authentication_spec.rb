feature 'user_authentication' do
  scenario 'user signs in & sees name on the home page' do
    register_user
    visit('/')
    fill_in('user_email', with: 'jondoe@example.org')
    fill_in('user_password', with: 'password')

    click_button('Login')

    expect(page).to have_content('Welcome, Jon')
  end

  scenario 'a user sees an error if they get their email wrong' do
    register_user
    visit('/')
    fill_in('user_email', with: 'dfgsdfgf@gfhs.com')
    fill_in('user_password', with: 'password')

    click_button('Login')
    expect(page).not_to have_content('Welcome, dfgsdfgf')
    expect(page).to have_content('Please check your email or password.')
  end

  scenario 'a user sees an error if they get their password wrong' do
    register_user
    visit('/')
    fill_in('user_email', with: 'jondoe@example.org')
    fill_in('user_password', with: 'passwort')

    click_button('Login')

    expect(page).not_to have_content('Welcome, janedoe@whatever.com')
    expect(page).to have_content('Please check your email or password.')
  end

  scenario 'a user can sign out' do
    register_user
    visit('/')
    fill_in('user_email', with: 'jondoe@example.org')
    fill_in('user_password', with: 'password')
    click_button('Login')
    click_button('Logout')
    
    expect(page).not_to have_content('Welcome, janedoe@whatever.com')
    expect(page).to have_content('You have logged out.')
  end
end
