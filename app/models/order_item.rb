class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  def fulfilled?
    self.fulfilled
  end

  def self.unfulfilled_merchant_orderitems
    all.where(item_id: [current_user.items.pluck(:id)]).where(fulfilled: false)
  end

end
