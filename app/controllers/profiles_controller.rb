class ProfilesController < ApplicationController
  before_action :set_user, :only => [:new]

  def new
    @profile = @user.build_profile
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
