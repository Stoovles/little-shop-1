class Admin::UsersController < ApplicationController
  def index
    @users = User.where(role: 0)
  end

  def show

  end

  def update
    @user = User.find(params[:id])
    if params[:update] == "upgrade"
      @user.update(role: 1)
      flash.notice = "#{@user.name} has been upgraded to a merchant"
      redirect_to admin_users_path
    end
  end
end
