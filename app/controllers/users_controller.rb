class UsersController < ApplicationController

require 'pry'
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to user_path, success: "You are now registered and logged in"
    else
      flash.now[:danger] = "This email address already exists"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name,
                                 :street_address,
                                 :state,
                                 :city,
                                 :zip_code,
                                 :email_address,
                                 :password,
                                 :password_confirmation)
  end




end
