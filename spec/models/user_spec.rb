require "rails_helper"

RSpec.describe User, type: :model do
  describe "Relationships" do
    it {should have_many :items}
    it {should have_many :orders}
  end

  describe "Class methods" do
    before :each do
      @u1 = User.create(name: "Ondrea Chadburn",street_address: "6149 Pine View Alley",city: "Wichita Falls",state: "Texas",zip_code: "76301",email_address: "ochadburn0@washingtonpost.com",password:"EKLr4gmM44", enabled: true, role:0)
      @u2 = User.create(name: "Raff Faust",street_address: "066 Debs Place",city: "El Paso",state: "Texas",zip_code: "79936",email_address: "rfaust1@naver.com",password:"ZCoxai", enabled: true, role:0)
      @u3 = User.create(name: "Con Chilver",street_address: "16455 Miller Circle",city: "Van Nuys",state: "California",zip_code: "91406",email_address: "cchilver2@mysql.com",password:"IrGmrINsmr9e", enabled: false, role:0)
    end

    it ".member_since" do
      expect(User.active_merchant).to eq([@u1, @u2])
    end
  end

  describe "Merchant methods" do
    before :each do
    end
  end
end
