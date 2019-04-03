require "rails_helper"

RSpec.describe Cart do
  before :each do
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
end
