class Dashboard::ItemsController < ApplicationController
  def index
    @items = Item.merchant_items(current_user)
  end
end
