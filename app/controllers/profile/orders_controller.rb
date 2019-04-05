class Profile::OrdersController < ApplicationController
  def index
    @orders = current_user.orders
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
