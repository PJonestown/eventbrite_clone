class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])

    # TODO: better way?
    @upcoming_events = @user.attended_events.where("date >= ?", Time.zone.today)
    @past_events = @user.attended_events.where("date < ?", Time.zone.today)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in_user @user
      flash[:success] = "Welcome #{@user.username}!"
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end
