class Admin::UsersController < ApplicationController
  def index
    @users = User.where(role: 0)
  end

  def show
    if User.find(params[:id]).role == "merchant"
      redirect_to admin_merchant_path(User.find(params[:id]))
    else
      @user = User.find(params[:id])
    end
  end 

  def update
    @user = User.find(params[:id])
    if params[:update] == "upgrade"
      @user.update(role: 1)
      redirect_to admin_merchant_path(@user), success: "#{@user.name} has been upgraded to a merchant"
    end
  end
end
