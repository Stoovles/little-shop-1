class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "You are now registered and logged in"
      redirect_to @user
    else
      render 'new'
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
