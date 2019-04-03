class CartsController < ApplicationController
before_action :require_visitor_or_user
  def show
  end

  def create
    
    redirect_to item_path(params[:item_id])
  end

private
  def require_visitor_or_user
    render file: "/public/404" unless current_user? || !current_user
  end
end
