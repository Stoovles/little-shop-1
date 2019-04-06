require 'rails_helper'

RSpec.describe 'On the merchant index page' do
  context 'as a visitor' do
    before :each do
      @u1 = User.create(name: "Ondrea Chadburn",street_address: "6149 Pine View Alley",city: "Wichita Falls",state: "Texas",zip_code: "76301",email_address: "ochadburn0@washingtonpost.com",password:"EKLr4gmM44", enabled: true, role:1)
      @u2 = User.create(name: "Raff Faust",street_address: "066 Debs Place",city: "El Paso",state: "Texas",zip_code: "79936",email_address: "rfaust1@naver.com",password:"ZCoxai", enabled: true, role:1)
      @u3 = User.create(name: "Con Chilver",street_address: "16455 Miller Circle",city: "Van Nuys",state: "California",zip_code: "91406",email_address: "cchilver2@mysql.com",password:"IrGmrINsmr9e", enabled: false, role:1)
    end
    it "I can see all the active merchants" do
      visit merchants_path

      expect(page).to have_content("#{@u1.name}")
      expect(page).to have_content("Ships from: #{@u1.city}, #{@u1.state}")
      expect(page).to have_content("Member since: #{@u1.created_at.to_date}")
    end
  end
end
