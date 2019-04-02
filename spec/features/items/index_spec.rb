require "rails_helper"

RSpec.describe "Items Index Page", type: :feature do
  before :each do
    @umerch = User.create(name: "Ondrea Chadburn",address: "6149 Pine View Alley",city: "Wichita Falls",state: "Texas",zipcode: 76301,email: "ochadburn0@washingtonpost.com",password_digest:"EKLr4gmM44")
    @uadmin = User.create(name: "Raff Faust",address: "066 Debs Place",city: "El Paso",state: "Texas",zipcode: 79936,email: "rfaust1@naver.com",password_digest:"ZCoxai")
    @u1 = User.create((name: "Con Chilver",address: "16455 Miller Circle",city: "Van Nuys",state: "California",zipcode: 91406,email: "cchilver2@mysql.com",password_digest:"IrGmrINsmr9e")

    @i1 = @umerch.items.create(item_name: "W.L. Weller Special Reserve",image: "http://www.buffalotracedistillery.com/sites/default/files/Weller_CYPB_750ml_front_LoRes.png",price: 20.0,inventory: 4, description:"A sweet nose with a presence of caramel. Tasting notes of honey, butterscotch, and a soft woodiness. It's smooth, delicate and calm. Features a smooth finish with a sweet honeysuckle flair.",enabled: true)
    @i2 = @umerch.items.create(item_name: "W.L. Weller C.Y.P.B.",image: "http://www.buffalotracedistillery.com/sites/default/files/weller%20special%20reserve%20brand%20page%5B1%5D.png",current_price: 35.0,inventory: 30, description:"A light aroma with citrus and oak on the nose. The palate is well rounded and balanced, with a medium-long finish and hints of vanilla.",enabled: false)
  end

  context "anyone visiting item catalog" do
    it "shows all enabled items and their info" do
      visit items_path
      within first ".item-card" do
        expect(page).to have_content(@i1.item_name)
        expect(page).to have_css("img[src*='#{@i1.image}']")
        expect(page).to have_content("Merchant: #{@i1.user.name}")
        expect(page).to have_content("In inventory: :#{@i1.inventory}")
        expect(page).to have_content("Price: $#{@i1.current_price}")
      end
      expect(page).to have_css(".item-card",count: 1)
      expect(page).to_not have_content(@i2.item_name)
    end

    it "links item name to item show page" do
      visit items_path
      within first ".item-card" do
        click_link "#{@i1.item_name}"
        expect(current_path).to eq(item_path(@i1))
      end
    end

    it "links item thumbnail to item show page" do
      visit items_path
      within first ".item-card" do
        find("#{@i1.image}").click
        expect(current_path).to eq(item_path(@i1))
      end
    end

    it "has a statistics section" do
      visit items_path
      within ".statistics" do
        expect(page).to have_css("Statistics:")
      end
    end

    it "shows the five most popular items by total quantity sold" do
      visit items_path
      within ".statistics" do
        expect(page).to have_content("Most Popular Items")
        expect(page).to have_css(".popular", count: 5)
      end
    end

    it "shows the five least popular items by total quantity sold" do
      visit items_path
      within ".statistics" do
        expect(page).to have_content("Least Popular Items")
        expect(page).to have_css(".unpopular", count: 5)
      end
    end
  end
end
