class MembershipsController < ApplicationController
  def create
    @group = Group.find(params[:membership][:group_membership_id])
    current_user.memberships.create(group_membership_id: @group.id)
    redirect_to(:back) 
  end

  def destroy
    @membership = Membership.find(params[:id])
    current_user.memberships.destroy(@membership)
    redirect_to(:back)
  end

  private

  def membership_params
    params.require(:membership).permit(:member_id, :group_membership_id)
  end
end
