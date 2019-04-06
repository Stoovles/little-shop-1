require "rails_helper"

RSpec.describe "As an admin who is logged in" do
  before :each do
    @uadmin = User.create!(name: "Darnell Topliss",street_address: "02 Monument Street",city: "Lincoln",state: "Nebraska",zip_code: "68515",email_address: "dtopliss6@unicef.org",password:"usJn1CuUB", enabled: true, role:2)
    @umerch = User.create(name: "Ondrea Chadburn",street_address: "6149 Pine View Alley",city: "Wichita Falls",state: "Texas",zip_code: "76301",email_address: "ochadburn0@washingtonpost.com",password:"EKLr4gmM44", enabled: true, role:1)
    @u1 = User.create(name: "Con Chilver",street_address: "16455 Miller Circle",city: "Van Nuys",state: "California",zip_code: "91406",email_address: "cchilver2@mysql.com",password:"IrGmrINsmr9e", enabled: true, role:0)
    @u4 = User.create(name: "Sibbie Cromett",street_address: "0 Towne Avenue",city: "Birmingham",state: "Alabama",zip_code: "35211",email_address: "scromett3@github.io",password:"fEFJeHdT1K", enabled: true, role:0)
    @u8 = User.create(name: "Tonya Baldock",street_address: "5 Bellgrove Crossing",city: "Yakima",state: "Washington",zip_code: "98902",email_address: "tbaldock7@wikia.com",password:"GN2dr6VfS", enabled: true, role:0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@uadmin)
  end

  describe "on all pages" do
    it "should have Users in the nav-bar" do
      visit root_path
      click_link "Users"
      expect(current_path).to eq(admin_users_path)
    end
  end

  describe "on admin users index page" do
    it "should show all the users in the system" do
      visit admin_users_path
      expect(page).to have_css(".user-card", count: 3)
      within first ".user-card" do
        expect(page).to have_link(@u1.name)
        expect(page).to have_content("Registered: #{@u1.created_at}")
        expect(page).to have_link("Upgrade to Merchant")
      end
      within ".users-container" do
        expect(page).to_not have_content("Darnell Topliss")
        expect(page).to_not have_content("Ondrea Chadburn")
      end
    end

    it "should link to user show pages via their name" do
      visit admin_users_path
      click_link "Con Chilver"
      expect(current_path).to eq(admin_user_path(@u1))
    end

    xit "should upgrade the user to a merchant and they can no longer be seen" do
      visit admin_users_path
      within first ".user-card" do
        click_link "Upgrade to Merchant"
        expect(current_path).to eq(admin_user_path(@u1)) #is this right?
      end
      visit admin_users_path
      expect(page).to_not have_content(@u1.name)
    end
  end

end
