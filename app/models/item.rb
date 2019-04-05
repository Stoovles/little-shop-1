class Item < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items

  def merchant_name
    User.where(id: self.user_id).first.name
  end

  def self.popular_five
    joins(:order_items).where("order_items.fulfilled": true, enabled: true).select("items.*, sum(order_items.quantity) as total").group(:id).order("total desc").limit(5)
  end

  def self.unpopular_five
    unpopular = []
    oi_item_ids = OrderItem.select(:item_id).distinct.pluck(:item_id)
    unpopular << Item.where.not(id: oi_item_ids).limit(5)
    unpopular << joins(:order_items).where("order_items.fulfilled": true).select("items.*, sum(order_items.quantity) as total").group(:id).order("total asc")
    unpopular.flatten![0..4]
  end

  def avg_fulfill_time
    # SELECT item_id, AVG(updated_at - created_at) from order_items WHERE item_id = 1 GROUP BY item_id; #THIS WORKS
    if OrderItem.find_by(item_id: self.id)
      time_diff = OrderItem.where(item_id: self.id).group(:item_id).pluck("AVG(updated_at - created_at)")
      time_diff[0].split(" ")[0,2].join(" ") #helper method in appcont
    else
      "no shipments yet"
    end
  end

  def quantity_sold
    OrderItem.where(item_id: self.id, fulfilled: true).sum(:quantity)
  end
end
