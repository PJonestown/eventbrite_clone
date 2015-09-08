class ProfilesController < ApplicationController
  before_action :set_user, :only => [:new, :create]

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
  end

  def edit
  end

  def update
  end

  private

  def profile_params
    params.require(:profile).permit(:zipcode)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
