class CartsController < ApplicationController
before_action :require_visitor_or_user
  def show
    ids = @cart.contents.keys
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
    else
      session[:cart][params[:item_id]] = params[:quantity].to_i
    end
    if @cart.contents.first == nil
      destroy
    else
      redirect_to cart_path
    end
  end

  def discount
    if current_user.my_used_coupons?(params["Coupon code"])
      flash.now[:danger] = "Coupon has already been used"
      render :show
    elsif current_user.available_coupons?(params["Coupon code"])
      flash.now[:danger] = "This coupon does not exist"
      render :show
    else
      redirect_to cart_path, info: "#{params["Coupon code"]} has been added"
    end
  end

private
  def require_visitor_or_user
    render file: "/public/404" unless current_user? || !current_user
  end
end
