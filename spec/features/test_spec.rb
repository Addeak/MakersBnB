feature 'test page' do
  scenario 'user can see a test page' do
    visit '/test'

    expect(page).to have_content 'Testing testing'
  end
end
