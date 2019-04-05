class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :user

  def item_quantity
    OrderItem.where(order_id: self.id).sum(:quantity)
  end

end
