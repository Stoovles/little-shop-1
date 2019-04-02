require "rails_helper"

RSpec.describe "Items Show Page" do
  before :each do
    @umerch = User.create(name: "Ondrea Chadburn",address: "6149 Pine View Alley",city: "Wichita Falls",state: "Texas",zipcode: 76301,email: "ochadburn0@washingtonpost.com",password_digest:"EKLr4gmM44")
    @uadmin = User.create(name: "Raff Faust",address: "066 Debs Place",city: "El Paso",state: "Texas",zipcode: 79936,email: "rfaust1@naver.com",password_digest:"ZCoxai")
    @u1 = User.create((name: "Con Chilver",address: "16455 Miller Circle",city: "Van Nuys",state: "California",zipcode: 91406,email: "cchilver2@mysql.com",password_digest:"IrGmrINsmr9e")

    @i1 = @umerch.items.create(item_name: "W.L. Weller Special Reserve",image: "http://www.buffalotracedistillery.com/sites/default/files/Weller_CYPB_750ml_front_LoRes.png",price: 20.0,inventory: 4, description:"A sweet nose with a presence of caramel. Tasting notes of honey, butterscotch, and a soft woodiness. It's smooth, delicate and calm. Features a smooth finish with a sweet honeysuckle flair.",enabled: true)
  end


  context "anyone visiting an item show page" do
    it "shows all the information for that item" do
      visit item_path(@i1)
      expect(page).to have_content(@i1.item_name)
      expect(page).to have_content(@i1.description)
      expect(page).to have_css("img[src*='#{@i1.image}']")
      expect(page).to have_content("Merchant: #{@i1.user.name}")
      expect(page).to have_content("In inventory: :#{@i1.inventory}")
      expect(page).to have_content("Price: $#{@i1.current_price}")
      expect(page).to have_content("Average time to ship: #{@i1.avg_fulfill_time}")
    end
  end

  context "as a visitor" do
    it "has a link to add this item to my cart" do
      visit item_path(@i1)
      expect(page).to have_link("Add to Cart")
    end
  end

  context "as a regular user" do
    it "has a link to add this item to my cart" do
      visit root_path
      click_link "Log in"
      fill_in "Email", with: @u1.email
      fill_in "Password", with: @u1.password
      click_button "Log in"
      visit item_path(@i1)
      expect(page).to have_link("Add to Cart")
    end
  end

  context "as a merchant or admin" do
    it "does not have a link to add item to my cart" do
      visit root_path
      click_link "Log in"
      fill_in "Email", with: @umerch.email
      fill_in "Password", with: @umerch.password
      click_button "Log in"
      visist item_path(@i1)
      expect(page).to_not have_link("Add to Cart")
    end

    it "does not have a link to add item to my cart" do
      # admin = User.new #what goes here?
      # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit root_path
      click_link "Log in"
      fill_in "Email", with: @uadmin.email
      fill_in "Password", with: @uadmin.password
      click_button "Log in"
      visist item_path(@i1)
      expect(page).to_not have_link("Add to Cart")
    end
  end
end
