class CartsController < ApplicationController
before_action :require_visitor_or_user
  def show
    ids = @cart.contents.keys
  end

  def create
    item = Item.find(params[:item_id])
    @cart.add_item(item.id)
    session[:cart] = @cart.contents
    redirect_to item_path(params[:item_id]), info: "You now have #{session[:cart][item.id.to_s]} #{item.item_name} in your cart."
  end

  def destroy
    session.delete(:cart)
    redirect_to cart_path
  end

  def update
    if params[:update] == "remove" || params[:quantity] == "0"
      session[:cart].delete(params[:item_id])
    else
      # binding.pry
      session[:cart][params[:item_id]] = params[:quantity].to_i
    end
    if @cart.contents.first == nil
      destroy
    else
      redirect_to cart_path
    end
  end

private
  def require_visitor_or_user
    render file: "/public/404" unless current_user? || !current_user
  end
end
