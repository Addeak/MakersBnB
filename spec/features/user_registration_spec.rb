feature "User registration" do
  scenario "A user can create an account" do
    register_user

    expect(page).to have_content("Welcome, Jon")
  end
end
