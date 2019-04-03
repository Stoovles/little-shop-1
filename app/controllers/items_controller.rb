class ItemsController < ApplicationController

  def index
    @items = Item.all.where(enabled: true)
  end

  def show
    @item = Item.find(params[:id])
  end

end
