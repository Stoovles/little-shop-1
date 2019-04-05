class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  def fulfilled?
    self.fulfilled
  end

  def self.unfulfilled_merchant_orderitems(merchant)
    all.where(item_id: [merchant.items.pluck(:id)]).where(fulfilled: false)
  end


end
