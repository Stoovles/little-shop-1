require 'rails_helper'

RSpec.describe "On the merchant coupons index" do
  before :each do
    @u1 = User.create(name: "Ondrea Chadburn",street_address: "6149 Pine View Alley",city: "Wichita Falls",state: "Texas",zip_code: "76301",email_address: "ochadburn0@washingtonpost.com",password:"EKLr4gmM44", enabled: true, role:1)

    @c1 = @u1.coupons.create(name: "WEEKEND15OFF",	discount: 0, amount: 15, active: 0)
    @c2 = @u1.coupons.create(name: "SUMMER20OFF",	discount: 0, amount: 20, active: 0)
    @c3 = @u1.coupons.create(name: "HOLIDAY15PERCENT",	discount: 1, amount: 15, active: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@u1)
    visit dashboard_coupons_path
  end

  it "should show my coupons" do
    expect(page).to have_css(".coupon-card", count: 3)
    expect(page).to have_link("#{@c1.name}")
  end


end
