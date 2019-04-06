class Admin::MerchantsController < ApplicationController
  def show
    @merchant = User.find(params[:id])
    @orders = @merchant.orders.where(status: 0)
    binding.pry
  end
end
