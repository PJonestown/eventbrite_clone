class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user
      sign_in_user(user)
    else
      # flash
      redirect_to new_user_path
    end
  end
end
