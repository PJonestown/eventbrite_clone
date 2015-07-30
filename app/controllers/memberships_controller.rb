class MembershipsController < ApplicationController
  def create
    # Determine whether request is coming from groups#show or join_request#index
    # if Group.find_by id: params[:group_id]

      @group = Group.find(params[:group_id])
      if @group.owner == current_user && @group.members.include?(current_user)
        @membership = Membership.new(membership_params)
        if @membership.save!
          redirect_to group_memberships_path(@group)
        else
          render :index
        end
      else
        #@group = Group.find(params[:membership][:group_membership_id])
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
end
