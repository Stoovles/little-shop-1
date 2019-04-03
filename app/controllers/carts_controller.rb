class CartsController < ApplicationController
before_action :require_visitor_or_user
  def show
  end

  def create
    session[:cart] ||= Hash.new(0)
    item = Item.find(params[:item_id])
    @cart = Cart.new(session[:cart])
    @cart.add_item(item.id)
    redirect_to item_path(params[:item_id]), info: "You now have #{session[:cart][item.id.to_s]} #{item.item_name} in your cart."
  end

private
  def require_visitor_or_user
    render file: "/public/404" unless current_user? || !current_user
  end
end
