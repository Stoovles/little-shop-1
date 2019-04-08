class Admin::UsersController < ApplicationController
  def index
    @users = User.where(role: 0)
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if params[:update] == "upgrade"
      @user.update(role: 1)
      redirect_to admin_merchant_path(@user), success: "#{@user.name} has been upgraded to a merchant"
    end
  end
end
