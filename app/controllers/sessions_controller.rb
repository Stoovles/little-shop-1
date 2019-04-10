class SessionsController < ApplicationController
  def new
    if current_user?
      redirect_to profile_path, alert: "You are already logged in."
    elsif current_merchant?
      redirect_to dashboard_path, alert: "You are already logged in."
    elsif current_admin?
      redirect_to root_path, alert: "You are already logged in."
    end
  end

  def create
    user = User.find_by(email_address: params[:email_address])
    if user && user.authenticate(params[:password]) && user.role == 'merchant'
      session[:user_id] = user.id
      redirect_to dashboard_path, success: "You are now logged in"
    elsif user && user.authenticate(params[:password]) && user.role == 'admin'
      session[:user_id] = user.id
      redirect_to admin_dashboard_path, success: "You are now logged in"
    elsif user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to profile_path, success: "You are now logged in"
    else
      flash.now[:danger] = "Incorrect email and/or password"
      render :new

    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end
