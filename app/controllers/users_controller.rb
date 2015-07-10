class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in_user @user
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end
