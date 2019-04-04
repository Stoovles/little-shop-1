require "rails_helper"

RSpec.describe Cart do
  before :each do
    @item = Item.new(id: 1,
            item_name: "W.L. Weller Special Reserve",
            description: "A sweet nose with a presence of caramel. Tasting notes of honey, butterscotch, and a soft woodiness. It's smooth, delicate and calm. Features a smooth finish with a sweet honeysuckle flair.",
            image_url: "http://www.buffalotracedistillery.com/sites/default/files/Weller_CYPB_750ml_front_LoRes.png",
            inventory: 4,
            current_price: 0.2e2,
            enabled: true)

    @cart = Cart.new({
      "1" => 3,
      "2" => 1,
      "3" => 2
      })
  end

  describe ".total_count" do
    it "should add up all cart items" do

      expect(@cart.total_count).to eq(6)
    end
  end

  describe ".count_of" do
    it "should count a specific item in a cart" do
      expect(@cart.count_of(1)).to eq(3)
    end
  end

  describe ".add_item" do
    it "should add item to my cart" do
      @cart.add_item(2)
      expect(@cart.count_of(2)).to eq(2)
    end
  end

  describe ".subtotal" do
    it "should calculate item quantity times price" do
      expect(@cart.subtotal(@item)).to eq(60.0)
    end
  end
end
