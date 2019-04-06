class Dashboard::ItemsController < ApplicationController
  before_action :require_merchant

  def index
    @items = Item.merchant_items(current_user)
  end

  def deactivate
  @item = Item.find(params[:id])
  @item.update(enabled: false)
  flash.notice = "Item #{@item.id} has been disabled"
  redirect_to dashboard_items_path
end

def activate
  @item = Item.find(params[:id])
  @item.update(enabled: true)
  flash.notice = "Item #{@item.id} has been enabled"
  redirect_to dashboard_items_path
end

  private

  def require_merchant
    render file: "/public/404" unless current_merchant?
  end
end
