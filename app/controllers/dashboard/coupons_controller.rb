class Dashboard::CouponsController < ApplicationController
  def index
    @coupons = current_user.coupons
  end

  def show
    @coupon = Coupon.find(params[:id])
  end
end
