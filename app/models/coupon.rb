class Coupon < ApplicationRecord
  belongs_to :user
  validates_presence_of :name, :discount, :amount, :active

  enum discount: ["dollar", "percent"]

  def customers
    x = User.joins(:coupons).where(role: 0)
    binding.pry
  end
end
