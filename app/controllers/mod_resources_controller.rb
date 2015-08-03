class ModResourcesController < ApplicationController
  before_action :correct_user_only

  def index
    @user = User.find(params[:user_id])
    @moderated_groups = @user.moderated_groups
    @owned_groups = @user.owned_groups
  end

  private

  def correct_user_only
    redirect_to :back unless signed_in? &&
                             current_user == User.find(params[:user_id])
  end
end
