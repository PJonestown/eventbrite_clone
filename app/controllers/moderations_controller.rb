class ModerationsController < ApplicationController
  before_action :group_owner_only

  def new
    @user = User.find(params[:user_id])
    @moderation = Moderation.new
  end

  private

  def group_owner_only
    redirect_to root_path unless current_user && current_user.owned_groups.any?
  end
end
