class Profile::OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def create
    binding.pry
    new_order = current_user.orders.create(status: "pending")
    session[:cart].each do |item_id, quantity|
      if session[:coupon]
        coupon = Coupon.find_by(name: session[:coupon])
        if coupon.discount == "percent"
          order_item_price = Item.find(item_id).current_price * coupon.amount
        end
      end
      OrderItem.create(order_id: new_order.id,
                        item_id: item_id,
                       quantity: quantity,
                    order_price: order_item_price)
    end
    session.delete(:cart)
    session.delete(:coupon)
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

def discount_total(coupon)
  regular_total = regular_items(coupon).inject(0) {|total, item| total += subtotal(item)}
  if coupon.discount == "dollar"
    if (cart_total - coupon.amount) < 0
      regular_total
    else
      cart_total - coupon.amount
    end
  elsif coupon.discount == "percent"
    if coupon.amount >= 100
      discount_total = discount_items(coupon).inject(0) {|total, item| total += subtotal(item)*((100 - coupon.amount)/100.0)}
    else
      discount_total = 0
    end
    discount_total + regular_total
  end
end
