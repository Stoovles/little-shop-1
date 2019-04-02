class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, success: "You are now registered and logged in"
    elsif @user.exists?(email_address: user_params[:email_address])
      render 'new', danger: "This email address already exists"
    else
      render 'new', danger: "You are missing required fields"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,
                                 :street_address,
                                 :state,
                                 :city,
                                 :zip_code,
                                 :password,
                                 :password_confirmation)
  end
end
