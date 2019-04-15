class AddDefaultToOrders < ActiveRecord::Migration[5.1]
  def change
    change_column :orders, :coupon_id, :bigint, :null => true
  end
end
