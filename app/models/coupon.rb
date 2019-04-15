class Coupon < ApplicationRecord
  belongs_to :user
  belongs_to :order, optional: true
  validates_presence_of :name, :discount
  validates_uniqueness_of :name
  validates :discount, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than_or_equal_to: 100 }




  def self.find_coupons(cart)
    where(user_id: [cart.items.pluck(:user_id)]).pluck(:name)
  end




end
