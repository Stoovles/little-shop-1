class ChangeCouponIdOnOrders < ActiveRecord::Migration[5.1]
  def change
    change_column_null :orders, :coupon_id, true
  end
end
