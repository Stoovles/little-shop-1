class Dashboard::CouponsController < ApplicationController
  before_action :require_merchant

  def new
    if current_user.coupons.count > 4
      redirect_to dashboard_coupons_path, danger: "Limit 5 coupons per merchant"
    else @coupon = Coupon.new
    end
  end

  def create
    @coupon = Coupon.new(coupon_params)
    if @coupon.save
      session[:coupon_id] = @coupon.id
      redirect_to dashboard_coupons_path, success: "Coupon #{@coupon.id} has been created"
    else
      render :new
    end
  end

  def index
    @coupons = current_user.coupons
  end

  def edit
    @coupon = Coupon.find(params[:id])
  end

  def update
    @coupon = Coupon.find(params[:id])

    if @coupon.update(coupon_params)
      redirect_to dashboard_coupons_path, success: "Coupon #{@coupon.id} has been updated"
    else
      render :edit
    end
  end

  def destroy
    @coupon = Coupon.find(params[:id])
    if @coupon.used
      redirect_to dashboard_coupons_path, danger: "Coupon #{@coupon.id} has been redeemed. Cannot Delete!"
    else
      @coupon.delete
      redirect_to dashboard_coupons_path, danger: "Coupon #{@coupon.id} has been deleted"
    end
  end

  def deactivate
    @coupon = Coupon.find(params[:id])
    @coupon.update(enabled: false)
    redirect_to dashboard_coupons_path,  danger: "Coupon #{@coupon.id} has been disabled"
  end

  def activate
    @coupon = Coupon.find(params[:id])
    @coupon.update(enabled: true)
    redirect_to dashboard_coupons_path, success: "Coupon #{@coupon.id} has been enabled"
  end

  private

  def require_merchant
    render file: "/public/404" unless current_merchant?
  end

  def coupon_params
    params.require(:coupon).permit(:name,
                                 :discount
                                ).merge(user_id: current_user.id)
  end

end
