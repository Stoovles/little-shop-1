require 'rails_helper'

RSpec.describe 'Login Page Workflow' do
  it 'can log in as a registered user with valid credentials' do
    user = User.create!(name: "Jeremy", role: 0,
                      street_address: "1331 17th St",
                      city: "Denver",
                      state: "CO",
                      zip_code: 80202,
                      email_address: "Jeremy@test_user.com",
                      password: "test",
                      enabled: true)

    visit root_path

    click_on "Log In"

    expect(current_path).to eq(login_path)

    fill_in "email_address", with: "Jeremy@test_user.com"
    fill_in "password", with: "test"

    click_on "Log Me In"

    expect(current_path).to eq(profile_path)
  end

  describe 'sad path' do
    it 'cannot log in with incorrect credentials' do
      user = User.create!(name: "Jeremy", role: 0,
                        street_address: "1331 17th St",
                        city: "Denver",
                        state: "CO",
                        zip_code: 80202,
                        email_address: "Jeremy@test_user.com",
                        password: "test",
                        enabled: true)

      visit login_path

      fill_in "email_address", with: user.email_address
      fill_in "password", with: "wrong"

      click_on "Log Me In"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Incorrect email and/or password")

      #submitting an empty form
      click_on "Log Me In"

      expect(page).to have_content("Incorrect email and/or password")


      fill_in "email_address", with: "wrong"
      fill_in "password", with: user.password

      click_on "Log Me In"

      expect(page).to have_content("Incorrect email and/or password")
    end
  end
end
