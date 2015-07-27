class ModerationsController < ApplicationController
  before_action :group_owner_only, :only => [:new]
  before_action :signed_in_users_only

  def new
    @user = User.find(params[:user_id])
    @moderation = Moderation.new
    @owned_groups = current_user.owned_groups
  end

  def create
    @moderation = Moderation.new(moderation_params)
    if user_owns_group?
      if @moderation.save
        redirect_to group_path(@moderation.moderated_group_id)
      else
        render :new
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    @moderation = Moderation.find(params[:id])
    if user_owns_group?
      @moderation.destroy
      redirect_to group_path(@moderation.moderated_group_id)
    else
      redirect_to root_path
    end
  end

  private

  def moderation_params
    params.require(:moderation).permit(:moderator_id, :moderated_group_id)
  end

  def group_owner_only
    redirect_to root_path unless current_user && current_user.owned_groups.any?
  end

  def signed_in_users_only
    redirect_to new_user_path unless signed_in?
  end

  def user_owns_group?
    current_user.owned_groups.any? { |group| group[:id] == @moderation.moderated_group_id }
  end
end
