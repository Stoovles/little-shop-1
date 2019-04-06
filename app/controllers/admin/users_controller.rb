class Admin::UsersController < ApplicationController
  def index
    @users = User.where(role: 0)
  end

  def show

  end

  def update

  end
end
