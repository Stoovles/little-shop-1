require "rails_helper"

RSpec.describe "Items Index Page", type: :feature do
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

    it "shows the five most popular items by total quantity" do
      visit items_path
      within ".statistics" do
        expect(page).to have_content("Most Popular Items")
        expect(page).to have_css(".popular", count: 5)
      end
    end

    it "shows the five least popular items by total quantity" do
      visit items_path
      within ".statistics" do
        expect(page).to have_content("Least Popular Items")
        expect(page).to have_css(".unpopular", count: 5)
      end
    end
  end
end
