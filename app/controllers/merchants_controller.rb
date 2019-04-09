class MerchantsController < ApplicationController
before_action :require_merchant
skip_before_action :require_merchant, only: [:index]
  def index
    @merchants = User.active_merchant
  end

  def show
    @merchant = User.find(current_user.id)
    @items = Item.merchant_items(current_user)
    @orders = @merchant.merchant_pending_orders
    @popular_five = @items.popular_five
    @top_3_states = User.top_three_states(@merchant)
  end

  private

  def require_merchant
    render file: "/public/404" unless current_merchant?
  end

end
