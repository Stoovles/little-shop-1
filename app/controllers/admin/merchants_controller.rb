class Admin::MerchantsController < ApplicationController
  def show
    @merchant = User.find(params[:id])
    @orders = @merchant.merchant_pending_orders
    @popular_five = @merchant.items.popular_five
  end

  def index
    @merchants = User.where(role: 1)
  end

  def deactivate
    @merchant = User.find(params[:id])
    @merchant.update(enabled: false)
    redirect_to admin_merchants_path,  danger: "Merchant #{@merchant.id} has been disabled"
  end

  def activate
    @merchant = User.find(params[:id])
    @merchant.update(enabled: true)
    redirect_to admin_merchants_path, success: "Merchant #{@merchant.id} has been enabled"
  end

end
