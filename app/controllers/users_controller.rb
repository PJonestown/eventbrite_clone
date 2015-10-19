class UsersController < ApplicationController
  def new
    @user = User.new
    @user.build_address
  end

  def show
    @user = User.find(params[:id])

    # TODO: better way?
    upcoming_events = @user.attended_events.where("date >= ?", Time.zone.today)
    upcoming_gatherings = @user.attended_gatherings.where("date >= ?", Time.zone.today)
    @upcoming_happenings = (upcoming_events + upcoming_gatherings).sort do |a, b|
      a.date <=> b.date
    end

    past_events = @user.attended_events.where("date < ?", Time.zone.today)
    past_gatherings = @user.attended_gatherings.where("date < ?", Time.zone.today)
    @past_happenings = (past_events + past_gatherings).sort do |a, b|
      a.date <=> b.date
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to new_user_address_path(@user)
      flash[:success] = "Welcome #{@user.username}!"
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :address_attributes => [:id,
                                                                    :location,
                                                                    :latitude,
                                                                    :longitude,
                                                                    :addressable_id,
                                                                    :addressable_type])
  end
end
