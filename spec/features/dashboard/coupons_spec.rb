require 'rails_helper'

RSpec.describe "merchant coupons" do
  before :each do
    @umerch = User.create(name: "Ondrea Chadburn",street_address: "6149 Pine View Alley",city: "Wichita Falls",state: "Texas",zip_code: "76301",email_address: "ochadburn0@washingtonpost.com",password:"EKLr4gmM44", enabled: true, role:1)
    @u1 = User.create(name: "Raff Faust",street_address: "066 Debs Place",city: "El Paso",state: "Texas",zip_code: "79936",email_address: "rfaust1@naver.com",password:"ZCoxai", enabled: true, role:0)
    @u2 = User.create(name: "Con Chilver",street_address: "16455 Miller Circle",city: "Van Nuys",state: "California",zip_code: "91406",email_address: "cchilver2@mysql.com",password:"IrGmrINsmr9e", enabled: false, role:0)
    @u3 = User.create(name: "Sibbie Cromett",street_address: "0 Towne Avenue",city: "Birmingham",state: "Alabama",zip_code: "35211",email_address: "scromett3@github.io",password:"fEFJeHdT1K", enabled: true, role:0)

    @c1 = @umerch.coupons.create(name: "WEEKEND15OFF",	discount: 0, amount: 15, active: 0)
    @c2 = @umerch.coupons.create(name: "SUMMER20OFF",	discount: 0, amount: 20, active: 0)
    @c3 = @umerch.coupons.create(name: "HOLIDAY15PERCENT",	discount: 1, amount: 15, active: 1)

    @u2.coupons << @c1
    @u1.coupons << @c1

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@umerch)
  end

  describe "on the merchant coupons index" do
    it "should show my coupons" do
      visit dashboard_coupons_path
      expect(page).to have_css(".coupon-card", count: 3)
      expect(page).to have_link("#{@c1.name}")
      click_link "#{@c1.name}"
      expect(current_path).to eq(dashboard_coupon_path(@c1))
    end
  end

  describe "on the coupon show page" do
    it "should show information about the coupon" do
      visit dashboard_coupon_path(@c1)
      expect(page).to have_content(@c1.name)
      expect(page).to have_content("$#{@c1.amount}.00 off")
      expect(page).to have_content("activated")

      visit dashboard_coupon_path(@c3)
      expect(page).to have_content("#{@c3.amount}% off")
    end

    it "should show a list of all users who have used the coupon" do
      visit dashboard_coupon_path(@c1)
      expect(page).to have_content("#{@u1.name}\n#{@u2.name}")
      expect(page).to_not have_content(@u3.name)
    end

    xit "should have an activate button for deactivated coupons" do

    end

    it "should have a deactivate button for active coupons" do
      visit dashboard_coupon_path(@c1)
      expect(page).to have_link("Deactivate")
      click_link("Deactivate")
      expect(current_path).to eq(dashboard_coupon_path(@c1))
      visit dashboard_coupon_path(@c1)
      expect(page).to have_content(@c1.active)
      expect(page).to have_link("Activate")
    end
  end



end
