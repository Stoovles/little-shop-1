class Dashboard::ItemsController < ApplicationController
  before_action :require_merchant

  def index
    @items = Item.merchant_items(current_user)
  end

  def destroy
    @item = Item.find(params[:id]).delete
    redirect_to dashboard_items_path
  end

  def deactivate
  @item = Item.find(params[:id])
  @item.update(enabled: false)
  redirect_to dashboard_items_path,  danger: "Item #{@item.id} has been disabled"
end

def activate
  @item = Item.find(params[:id])
  @item.update(enabled: true)
  redirect_to dashboard_items_path, success: "Item #{@item.id} has been enabled"
end

  private

  def require_merchant
    render file: "/public/404" unless current_merchant?
  end
end
