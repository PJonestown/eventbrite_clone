class MembershipsController < ApplicationController
  before_action :user_only, :except => [:index]
  before_action :correct_user_only, :only => [:destroy]
  before_action :owner_and_mods_only_if_private, :only => [:create]

  def create
    @group = Group.find(params[:group_id])
    if new_memberships_permission? && @group.members.include?(current_user)
      @membership = Membership.new(membership_params)
      if @membership.save
        redirect_to group_memberships_path(@group)
      else
        render :index
      end
    else
      current_user.memberships.create(group_membership_id: @group.id)
      redirect_to(:back)
    end
  end

  def destroy
    @membership = Membership.find(params[:id])
    current_user.memberships.destroy(@membership)
    redirect_to(:back)
  end

  def index
    @group = Group.find(params[:group_id])
    @memberships = @group.memberships
  end

  private

  def membership_params
    params.require(:membership).permit(:member_id, :group_membership_id)
  end

  def user_only
    redirect_to :back unless signed_in?
  end

  def correct_user_only
    @membership = Membership.find(params[:id])
    redirect_to :back unless current_user.id == @membership.member_id
  end

  # TODO: Needs refactor
  def owner_and_mods_only_if_private
    @group = Group.find(params[:group_id])
    if @group.is_private
      redirect_to :back unless @group.owner == current_user ||
                               @group.moderators.include?(current_user)
    end
  end
end
