require 'rails_helper'

RSpec.describe 'Register Page Workflow' do
  it 'can register a user with valid credentials' do

    visit new_user_path


    expect(current_path).to eq(new_user_path)

    fill_in "Name", with: "Jerem Ben"
    fill_in "Street address", with: "8 Chestnut Place"
    fill_in "City", with: "Denver"
    fill_in "State", with: "TX"
    fill_in "Zip code", with: "02652"
    fill_in "Email address", with: "tester@test.com"
    fill_in "Password", with: "pass"
    fill_in "Confirmation Password", with: "pass"

    click_on "Create my account"
    expect(current_path).to eq(profile_path)
  end

  it 'throws error when any validations fail' do
    visit new_user_path

    expect(current_path).to eq(new_user_path)

    fill_in "Name", with: "Jerem Ben"
    fill_in "Street address", with: "8 Chestnut Place"
    fill_in "City", with: "Denver"
    fill_in "State", with: "TX"
    fill_in "Zip code", with: "02652"
    fill_in "Email address", with: "tester@test.com"
    fill_in "Password", with: "pass"
    fill_in "Confirmation Password", with: "wrong"

    click_on "Create my account"
    expect(current_path).to eq(profile_path)

  end
end
