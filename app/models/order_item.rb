class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  def fulfilled?
    self.fulfilled
  end

  def subtotal
    quantity * order_price
  end
end
