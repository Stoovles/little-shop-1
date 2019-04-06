class Profile::OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def create
    new_order = current_user.orders.create(status: "pending")
    session[:cart].each do |item_id, quantity|
      order_item_price = Item.find(item_id).current_price * quantity
      OrderItem.create(order_id: new_order.id,
                        item_id: item_id,
                       quantity: quantity,
                    order_price: order_item_price,)
    end
    session.delete(:cart)
    redirect_to profile_orders_path, success: 'Your order was successfully created!'
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(status: 3)
    flash.notice = "Order #{@order.id} has been cancelled"
    redirect_to profile_path
  end
end
