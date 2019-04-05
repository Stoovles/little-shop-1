class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :user

  enum status: ["pending", "packaged", "shipped", "cancelled"]

  def item_quantity
    OrderItem.where(order_id: self.id).sum(:quantity)
  end

  def total
    OrderItem.where(order_id: self.id).sum("quantity*order_price")
    #SELECT sum(quantity*order_price) FROM order_items WHERE order_id = 1;
  end

end
