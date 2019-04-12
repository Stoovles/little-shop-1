require "rails_helper"

RSpec.describe Coupon, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :discount}
    it {should validate_presence_of :amount}
    it {should validate_presence_of :active}
  end

  describe "relationships" do
    it {should belong_to :user}
  end

  before :each do
    @umerch = User.create(name: "Ondrea Chadburn",street_address: "6149 Pine View Alley",city: "Wichita Falls",state: "Texas",zip_code: "76301",email_address: "ochadburn0@washingtonpost.com",password:"EKLr4gmM44", enabled: true, role:1)
    @u1 = User.create(name: "Raff Faust",street_address: "066 Debs Place",city: "El Paso",state: "Texas",zip_code: "79936",email_address: "rfaust1@naver.com",password:"ZCoxai", enabled: true, role:0)
    @u2 = User.create(name: "Con Chilver",street_address: "16455 Miller Circle",city: "Van Nuys",state: "California",zip_code: "91406",email_address: "cchilver2@mysql.com",password:"IrGmrINsmr9e", enabled: false, role:0)
    @u3 = User.create(name: "Sibbie Cromett",street_address: "0 Towne Avenue",city: "Birmingham",state: "Alabama",zip_code: "35211",email_address: "scromett3@github.io",password:"fEFJeHdT1K", enabled: true, role:0)

    @c1 = @umerch.coupons.create(name: "WEEKEND15OFF",	discount: 0, amount: 15, active: 0)
    @c2 = @umerch.coupons.create(name: "SUMMER20OFF",	discount: 0, amount: 20, active: 0)
    @c3 = @umerch.coupons.create(name: "HOLIDAY15PERCENT",	discount: 1, amount: 15, active: 1)



  end

  describe ".customers" do
    it "should list the users who have used this coupon in an order" do
      @u2.coupons << @c1
      @u1.coupons << @c1
      expect(@c1.customers).to eq([@u1,@u2])
    end
  end
end
