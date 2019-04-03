class UsersController < ApplicationController

require 'pry'
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, success: "You are now registered and logged in"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.skip_password_validation = true
    if user_params[:password].blank?
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end
    if @user.update_attributes(user_params)
      redirect_to @user, success: "Profile updated"
    else
      render :edit
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
