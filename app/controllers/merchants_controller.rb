class MerchantsController < ApplicationController
before_action :require_merchant
skip_before_action :require_merchant, only: [:index]
  def index
    @merchants = User.active_merchant
  end

  def show
    @user = User.find(current_user.id)
    @items = Item.merchant_items(current_user)
    @orders = @user.merchant_pending_orders
    @popular_five = @items.popular_five
  end

  private

  def require_merchant
    render file: "/public/404" unless current_merchant?
  end

end
