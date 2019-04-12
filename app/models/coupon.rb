class Coupon < ApplicationRecord
  has_many :user_coupons
  has_many :users, through: :user_coupons
  validates_presence_of :name, :discount, :amount, :active

  enum discount: ["dollar", "percent"]
  enum active: ["activated","deactivated"]

  def customers
    User.joins(:coupons).where(role: 0)
  end

end
