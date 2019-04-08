class Admin::MerchantsController < ApplicationController
  def show
    @merchant = User.find(params[:id])
    @orders = @merchant.merchant_pending_orders
  end
end
