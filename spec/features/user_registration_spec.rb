feature "User registration" do
  scenario "A user can create an account" do
    visit("/users/register")
    fill_in("First name", with: "Jon")
    fill_in("Surname", with: "Doe")
    fill_in("Email", with: "jondoe@whatever.com")
    fill_in("Password", with: "password")
    fill_in("Confirm password", with: "password")
    fill_in("Phone number", with: "07123456789")
    click_button("Submit")

    expect(page).to have_content("Welcome, jondoe@whatever.com")
  end
end
