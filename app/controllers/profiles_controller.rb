class ProfilesController < ApplicationController
  before_action :set_user, :only => [:new, :create, :show]

  def new
    @profile = @user.build_profile
  end

  def create
    @profile = @user.build_profile(profile_params)
    if @profile.save
      redirect_to user_profile_path(@user, @profile)
      flash[:success] = "Welcome #{@user.username}"
    else
      render :new
    end
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def edit
  end

  def update
  end

  private

  def profile_params
    params.require(:profile).permit(:location)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
