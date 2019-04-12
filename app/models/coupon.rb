class Coupon < ApplicationRecord
  has_many :user_coupons
  has_many :users, through: :user_coupons
  validates_presence_of :name, :discount, :amount, :active

  enum discount: ["dollar", "percent"]

  def customers
    x = User.joins(:coupons).where(role: 0)
    binding.pry
  end
end
