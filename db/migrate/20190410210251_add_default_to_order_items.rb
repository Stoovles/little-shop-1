class AddDefaultToOrderItems < ActiveRecord::Migration[5.1]
  def change
    change_column :order_items, :fulfilled, :boolean, :default => false
  end
end
