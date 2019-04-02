require 'rails_helper'

RSpec.describe 'Login Page Workflow' do
  xit 'can log in as a registered user with valid credentials' do
    user = User.create(name: "Jeremy", role: 0,
                      street_address: "1331 17th St",
                      city: "Denver",
                      zip_code: 80202,
                      email_address: "Jeremy@test_user.com",
                      password: "test")

    # visit root_path
    #
    # click_on "Login"

    visit login_path

    expect(current_path).to eq(login_path)
    fill_in "username", with: user.username
    fill_in "password", with: user.password

    click_on "Log In"

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("Welcome back, #{user.name}, you've successfully logged in.")
  end

  describe 'sad path' do
    xit 'cannot log in with incorrect credentials' do
      user = User.create(name: "Jeremy", role: 0,
                        street_address: "1331 17th St",
                        city: "Denver",
                        zip_code: 80202,
                        email_address: "Jeremy@test_user.com",
                        password: "test")

      visit root_path

      click_on "Login"

      fill_in "username", with: user.username
      fill_in "password", with: "wrong"

      expect(current_path).to eq(root_path)
      epect(page).to have_content("Incorrect email and/or password")

      visit login_path

      fill_in "username", with: "wrong"
      fill_in "password", with: user.password

      expect(current_path).to eq(root_path)
      epect(page).to have_content("Incorrect email and/or password")
    end
  end
end
