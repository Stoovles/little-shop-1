class MerchantsController < ApplicationController
before_action :require_merchant
skip_before_action :require_merchant, only: [:index]
  def index
    @merchants = User.active_merchant
  end

  def show
  end

  private

  def require_merchant
    render file: "/public/404" unless current_merchant?
  end

end
