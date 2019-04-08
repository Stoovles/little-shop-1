class Dashboard::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @item = Item.find(@order.order_items[0].item_id)
    @order.order_items[0].update(fulfilled: true)
    new_inventory = @item.inventory - @order.order_items[0].quantity
    @item.update(inventory: new_inventory)
    flash.notice = "You have fulfilled #{@item.item_name}"
    redirect_to dashboard_order_path(@order)
  end

end
