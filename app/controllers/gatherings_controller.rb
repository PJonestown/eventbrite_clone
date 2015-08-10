class GatheringsController < ApplicationController
  before_action :members_only, :only => [:new, :create]
  before_action :correct_users_only, :only => [:update]

  def new
    @group = Group.find(params[:group_id])
    @gathering = @group.gatherings.build
  end

  def create
    @group = Group.find(params[:group_id])
    @gathering = @group.gatherings.build(gathering_params)
    @gathering.creator_id = current_user.id
    @gathering.approved = false if @group.restricted && !privileged_member?
    if @gathering.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:group_id])
    @gathering = Gathering.find(params[:id])
  end

  # TODO: Too many lines. Need to DRY
  def update
    @group = Group.find(params[:group_id])
    @gathering = Gathering.find(params[:id])
    if privileged_member?
      if @gathering.update(mod_restricted_gathering_params)
        redirect_to :back
      else
        redirect_to root_path
      end
    else
      if @gathering.update(creator_restricted_gathering_params)
        redirect_to :back
      else
        redirect_to root_path
      end
    end
  end

  private

  def gathering_params
    params.require(:gathering).permit(:name, :description, :date, :approved)
  end


  def mod_restricted_gathering_params
    params.require(:gathering).permit(:approved)
  end

  def creator_restricted_gathering_params
    params.require(:gathering).permit(:name, :description, :date)
  end

  def members_only
    @group = Group.find(params[:group_id])
    redirect_to :back unless signed_in? && @group.members.include?(current_user)
  end

  def correct_users_only
    @group = Group.find(params[:group_id])
    @gathering = Gathering.find(params[:id])
    redirect_to root_path unless signed_in?
    redirect_to root_path unless current_user.id == @gathering.creator_id ||
                                 privileged_member?
  end
end
