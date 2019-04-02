require "rails_helper"

RSpec.describe "Items Index Page", type: :feature do
  before :each do
    @umerch = User.create(name: "Ondrea Chadburn",street_address: "6149 Pine View Alley",city: "Wichita Falls",state: "Texas",zip_code: "76301",email_address: "ochadburn0@washingtonpost.com",password:"EKLr4gmM44", enabled: true, role:1)
    @uadmin = User.create(name: "Raff Faust",street_address: "066 Debs Place",city: "El Paso",state: "Texas",zip_code: "79936",email_address: "rfaust1@naver.com",password:"ZCoxai", enabled: true, role:1)
    @u1 = User.create(name: "Con Chilver",street_address: "16455 Miller Circle",city: "Van Nuys",state: "California",zip_code: "91406",email_address: "cchilver2@mysql.com",password:"IrGmrINsmr9e", enabled: true, role:1)

    @i1 = @umerch.items.create(item_name: "W.L. Weller Special Reserve",image_url: "http://www.buffalotracedistillery.com/sites/default/files/Weller_CYPB_750ml_front_LoRes.png",current_price: 20.0,inventory: 4, description:"A sweet nose with a presence of caramel. Tasting notes of honey, butterscotch, and a soft woodiness. It's smooth, delicate and calm. Features a smooth finish with a sweet honeysuckle flair.",enabled: true)

    @i2 = @umerch.items.create(item_name: "W.L. Weller C.Y.P.B.",image_url: "http://www.buffalotracedistillery.com/sites/default/files/weller%20special%20reserve%20brand%20page%5B1%5D.png",current_price: 35.0,inventory: 30, description:"A light aroma with citrus and oak on the nose. The palate is well rounded and balanced, with a medium-long finish and hints of vanilla.",enabled: true)
  end

  context "anyone visiting item catalog" do
    xit "shows all enabled items and their info to a visitor" do
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

    xit "shows all enabled items and their info to an admin" do
      visit root_path
      click_link "Log in"
      fill_in "Email", with: @uadmin.email
      fill_in "Password", with: @uadmin.password
      click_button "Log in"
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

    xit "links item name to item show page" do
      visit items_path
      within first ".item-card" do
        click_link "#{@i1.item_name}"
        expect(current_path).to eq(item_path(@i1))
      end
    end

    xit "links item thumbnail to item show page" do
      visit items_path
      within first ".item-card" do
        find("#{@i1.image}").click
        expect(current_path).to eq(item_path(@i1))
      end
    end

    xit "has a statistics section" do
      visit items_path
      within ".statistics" do
        expect(page).to have_css("Statistics:")
      end
    end

    xit "shows the five most popular items by total quantity sold" do
      visit items_path
      within ".statistics" do
        expect(page).to have_content("Most Popular Items")
        expect(page).to have_css(".popular", count: 5)
      end
    end

    xit "shows the five least popular items by total quantity sold" do
      visit items_path
      within ".statistics" do
        expect(page).to have_content("Least Popular Items")
        expect(page).to have_css(".unpopular", count: 5)
      end
    end
  end
end
