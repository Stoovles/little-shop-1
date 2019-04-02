class UsersController < ApplicationController
require 'pry'
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # binding.pry
      redirect_to @user, success: "You are now registered and logged in"
    else
      # flash.now[:danger] = "This email address already exists"
      # binding.pry
      render :new
    end
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
