require "rails_helper"

RSpec.describe "As any user on the welcome page" do
  before :each do
    visit root_path
  end
  describe "website description" do
    it "should show information about the website" do
      expect(page).to have_content("Welcome to Little Shop of Whiskeys!")
      expect(page).to have_css(".about-site")

    end
    describe "as a visitor" do
      it "should have a login or register section" do
        within ".welcome-login" do
          expect(page).to have_content("Log In")
          expect(page).to have_button("Log Me In")
          expect(page).to have_link("Not a Member? Register Here")
          click_link "Not a Member? Register Here"
          expect(current_path).to eq(new_user_path)
        end
      end
    end

    describe "as a logged in user/merchant/admin" do
      it "should have a welcome section with logout button" do
        within ".welcome-login" do
          expect(page).to have_content("Log In")
          expect(page).to have_css("#email_address")
          expect(page).to have_css("#password")
          expect(page).to have_button("Log Me In")
          click_link "Not a Member? Register Here"
          expect(current_path).to eq new_user_path
        end
      end

      it "should have an items/merchants section" do
        within ".welcome-nav-section" do
          expect(page).to have_content("Browse")
          expect(page).to have_link("All Items")
          expect(page).to have_link("All Merchants")
        end
      end
    end

    describe "as a merchant"
      it "should have a welcome section with logout button" do
        merchant = User.create(name: "Madelon Hicken",street_address: "3830 Becker Trail",city: "Saint Louis",state: "Missouri",zip_code: "63116",email_address: "mhickenf@unesco.org",password:"q9qDA9PA", enabled: true, role:1)
        # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)
        visit login_path
        fill_in "email_address", with: merchant.email_address
        fill_in "password", with: merchant.password
        click_button "Log Me In"
        visit root_path
        expect(page).to have_link("Dashboard")
        within ".welcome-login" do
          expect(page).to have_content("Welcome, #{merchant.name}")
          expect(page).to have_link("Log Out")
        end
      end
    end
    describe "creators description" do
      it "should have a blurb about us and the project" do
        expect(page).to have_content("About Creators")
        expect(page).to have_link("Jeremy Bennett's Github")
        expect(page).to have_link("Ethan Grab's Github")
        expect(page).to have_link("Carrie Walsh's Github")
        expect(page).to have_link("Matt Weiss's Github")
      end
    end
  end
