require 'rails_helper'

RSpec.describe "merchant coupons" do
  before :each do
    @umerch = User.create(name: "Ondrea Chadburn",street_address: "6149 Pine View Alley",city: "Wichita Falls",state: "Texas",zip_code: "76301",email_address: "ochadburn0@washingtonpost.com",password:"EKLr4gmM44", enabled: true, role:1)

    @c1 = @umerch.coupons.create(name: "WEEKEND15OFF",	discount: 0, amount: 15, active: 0)
    @c2 = @umerch.coupons.create(name: "SUMMER20OFF",	discount: 0, amount: 20, active: 0)
    @c3 = @umerch.coupons.create(name: "HOLIDAY15PERCENT",	discount: 1, amount: 15, active: 1)

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
      expect(page).to have_content("#{@c1.active}")

      visit dashboard_coupon_path(@c3)
      expect(page).to have_content("#{@c3.amount}% off")
    end

    it "should show a list of all users who have used the coupon" do
      visit dashboard_coupon_path(@c1)
      expect(page).to have_content()
    end

    xit "should have an activate button for disactivated coupons" do

    end

    xit "should have a disactivate button for active coupons" do

    end
  end



end
