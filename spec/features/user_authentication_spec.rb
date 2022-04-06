xfeature 'user_authentication' do
  scenario 'user signs in & sees name on the home page' do
    visit('/')

    fill_in('user_name', with: 'John Doe')
    fill_in('password', with: 'password')

    click_button('Login')

    expect(page).to have_content('John Doe')
  end

  scenario 'wrong user name throws error' do
    visit('/')

    fill_in('user_name', with: 'dfgsdfgf gfhs')
    fill_in('password', with: 'password')

    click_button('Login')

    expect(page).to have_content('Invalid User Name!')
  end

  scenario 'wrong user name throws error' do
    visit('/')
    
    fill_in('user_name', with: 'John Doe')
    fill_in('password', with: 'fdgsfg')

    click_button('Login')

    expect(page).to have_content('Invalid password!')
  end
