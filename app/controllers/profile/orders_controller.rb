class Profile::OrdersController < ApplicationController
  def index
    @orders = current_user.orders
    @coupon = session[:coupon]
  end

  def create
    if session[:coupon]
      #if coupon is applied
      new_order = current_user.orders.create(status: "pending", coupon_id: session[:coupon]["id"])
      session[:cart].each do |item_id, quantity|
        item = Item.find(item_id)
        order_item_price = @cart.discount_price(item, session[:coupon]) * quantity
        OrderItem.create(order_id: new_order.id,
                          item_id: item_id,
                         quantity: quantity,
                      order_price: order_item_price)

      end
      #update coupon to used: true
      Coupon.find(session[:coupon]["id"]).update(used: true)
    else
      #if no coupon is applied
      new_order = current_user.orders.create(status: "pending")
      session[:cart].each do |item_id, quantity|
        order_item_price = Item.find(item_id).current_price * quantity
        OrderItem.create(order_id: new_order.id,
                          item_id: item_id,
                         quantity: quantity,
                      order_price: order_item_price)
      end

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
    redirect_to profile_path, danger: "Order #{@order.id} has been cancelled"
  end
end
