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
end
