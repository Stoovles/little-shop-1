class CartsController < ApplicationController
before_action :require_visitor_or_user
  def show
    ids = @cart.contents.keys
    @merchant_coupons = Coupon.find_coupons(@cart)
  end

  def create
    item = Item.find(params[:item_id])
    @cart.add_item(item.id)
    session[:cart] = @cart.contents
    redirect_to items_path, info: "You now have #{session[:cart][item.id.to_s]} #{item.item_name} in your cart."
  end

  def destroy
    session.delete(:cart)
    redirect_to cart_path
  end

  def update
    if params[:update] == "remove" || params[:quantity] == "0"
      session[:cart].delete(params[:item_id])
    elsif params[:update] == "coupon"
      if Order.unique_coupon?(params, current_user)
        redirect_to cart_path, danger: "You have already used this coupon"
      else
      session[:coupon] = Coupon.find_by(name: params[:coupon])
      redirect_to cart_path, success: "Coupon has been applied"
      end
    elsif params[:update] == "quantity"
      session[:cart][params[:item_id]] = params[:quantity].to_i
      redirect_to cart_path, success: "Quantity Updated"
    end

    if @cart.contents.first == nil
      destroy
    end
  end

private
  def require_visitor_or_user
    render file: "/public/404" unless current_user? || !current_user
  end
end
