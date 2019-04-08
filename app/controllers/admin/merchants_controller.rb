class Admin::MerchantsController < ApplicationController
  def show
    @merchant = User.find(params[:id])
    @orders = @merchant.merchant_pending_orders
    @popular_five = @merchant.items.popular_five
  end

  def index
    @merchants = User.where(role: 1)
  end
end
