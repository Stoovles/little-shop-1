class Dashboard::ItemsController < ApplicationController
  before_action :require_merchant

  def index
    @items = Item.merchant_items(current_user)
  end

  private

  def require_merchant
    render file: "/public/404" unless current_merchant?
  end
end
