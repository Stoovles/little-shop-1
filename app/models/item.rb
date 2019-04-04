class Item < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items

  def merchant_name
    User.where(id: self.user_id).first.name
  end

  def avg_fulfill_time
    # x = OrderItem.where(item_id: self.id, fulfilled: true).select("order_item.item_id, AVG(updated_at - created_at) AS average_fulfill_time").group(:item_id).order("average_fulfill_time")
    # x = OrderItem.select("AVG(order_items.updated_at - order_items.created_at) as avg_f_time").where(item_id: self.id, fulfilled: true).group(:item_id)
  end

  def quantity_sold
    OrderItem.where(item_id: self.id, fulfilled: true).sum(:quantity)
  end
end
