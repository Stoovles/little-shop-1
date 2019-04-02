class ItemsController < ApplicationController

  def index
    @items = Item.all.where(enabled: true)
  end

end
