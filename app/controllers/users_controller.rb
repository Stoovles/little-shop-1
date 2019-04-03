class UsersController < ApplicationController
before_action :require_user
skip_before_action :require_user, only: [:new, :create]
  def new
    @user = User.new
  end

  def create

    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to profile_path, success: "You are now registered and logged in"
    else
      render :new
    end
  end

  def show
    # binding.pry
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(current_user.id)

    # @user.skip_password_validation = true
    if user_params[:password].blank?
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end
    if @user.update_attributes(user_params)
      redirect_to profile_path, success: "Profile updated"
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

  def require_user
    render file: "/public/404" unless current_user?
  end



end
