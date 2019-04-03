require 'rails_helper'

RSpec.describe 'As a registered user' do
  before :each do
    @user = User.create!(name: "Jeremy", role: 0,
                      street_address: "1331 17th St",
                      city: "Denver",
                      state: "CO",
                      zip_code: 80202,
                      email_address: "Jeremy@test_user.com",
                      password: "password",
                      enabled: true)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end
  it "I can edit my profile information" do
    visit user_path(@user)

    click_link "Edit my profile"

    expect(current_path).to eq(edit_user_path)
  end
end
