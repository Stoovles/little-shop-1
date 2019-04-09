class Admin::AdminsController < ApplicationController
before_action :require_admin
  def show
    @packaged_orders = Order.where(status: 1)
    @pending_orders = Order.where(status: 0)
    @shipped_orders = Order.where(status: 2)
    @cancelled_orders = Order.where(status: 3)
    @orders = [@packaged_orders,
               @pending_orders,
               @shipped_orders,
               @cancelled_orders
             ].flatten
  end

private

  def require_admin
    render file: "/public/404" unless current_admin?
  end
end
