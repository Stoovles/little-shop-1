class Dashboard::CouponsController < ApplicationController
  before_action :require_merchant
  before_action :coupon_limit, only: [:new, :create]

  def index
    @coupons = current_user.coupons
    @count = @coupons.count
  end

  def show
    @coupon = Coupon.find(params[:id])
    @users = @coupon.customers
  end

  def new

  end

  def edit
    @coupon = Coupon.find(params[:id])
  end

  def update
    coupon = Coupon.find(params[:id])
    coupon.update(update_params)
    redirect_to dashboard_coupon_path(coupon), success: "You have successfully updated #{coupon.name}"
  end

  def deactivate
    coupon = Coupon.find(params[:id])
    coupon.update(active: 1)
    redirect_to dashboard_coupon_path(coupon)
  end

  def activate
    coupon = Coupon.find(params[:id])
    coupon.update(active: 0)
    redirect_to dashboard_coupon_path(coupon)
  end

  def destroy
    coupon = Coupon.find(params[:id])
    coupon.destroy
    redirect_to dashboard_coupons_path, success: "You have deleted #{coupon.name}"
  end

  private

  def require_merchant
    render file: "/public/404" unless current_merchant?
  end

  def coupon_limit
    render file: "/public/404" unless coupon_limit?
  end

  def update_params
    up = params.require(:coupon).permit(:name,:discount,:amount)
  end
end
