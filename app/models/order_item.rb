class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  def fulfilled?
    self.fulfilled
  end
end
