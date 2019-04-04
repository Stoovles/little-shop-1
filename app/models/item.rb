class Item < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items

  def merchant_name
    User.where(id: self.user_id).first.name
  end

  def self.popular_five
    joins(:order_items).where("order_items.fulfilled": true).select("items.*, sum(order_items.quantity) as total").group(:id).order("total desc")
  end

  def self.unpopular_five
    unpopular = []
    oi_item_ids = OrderItem.select(:item_id).distinct.pluck(:item_id)
    unpopular << Item.where.not(id: oi_item_ids).limit(5)
    unpopular << joins(:order_items).where("order_items.fulfilled": true).select("items.*, sum(order_items.quantity) as total").group(:id).order("total asc")
    unpopular[0..4]
  end

  def avg_fulfill_time
    # x = OrderItem.where(item_id: self.id, fulfilled: true).select("order_item.item_id, AVG(updated_at - created_at) AS average_fulfill_time").group(:item_id).order("average_fulfill_time")
    # x = OrderItem.select("AVG(order_items.updated_at - order_items.created_at) as avg_f_time").where(item_id: self.id, fulfilled: true).group(:item_id)
  end

  def quantity_sold
    OrderItem.where(item_id: self.id, fulfilled: true).sum(:quantity)
  end
end
