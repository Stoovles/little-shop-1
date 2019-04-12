class Dashboard::CouponsController < ApplicationController
  before_action :require_merchant

  def index
    @coupons = current_user.coupons
  end

  def show
    @coupon = Coupon.find(params[:id])
    @users = @coupon.customers
  end

  def update
    coupon = Coupon.find(params[:id])
    coupon.update(active: 1)
    redirect_to dashboard_coupon_path(coupon)
  end

  private

  def require_merchant
    render file: "/public/404" unless current_merchant?
  end
end
