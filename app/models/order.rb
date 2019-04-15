class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :user
  belongs_to :coupon, optional: true

  enum status: ["pending", "packaged", "shipped", "cancelled"]

  def self.unique_coupon?(params, current_user)
    if where(coupon_id: Coupon.find_by(name: params[:coupon])).where(user_id: current_user.id).count > 0
      true
    else false 
    end
  end

  def item_quantity
    OrderItem.where(order_id: self.id).sum(:quantity)
  end

  def total
    OrderItem.where(order_id: self.id).sum("quantity*order_price")
    #SELECT sum(quantity*order_price) FROM order_items WHERE order_id = 1;
  end

  def item_fulfilled?(item)
    order_items.where(item_id: item.id).first.fulfilled?
  end

  def order_fulfilled?
    order_items.all? do |order_item|
      order_item.fulfilled?
    end
  end

  def user_name
    user = User.find(self.user_id)
    user.name
  end




end
