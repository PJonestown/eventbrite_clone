class GatheringsController < ApplicationController
  before_action :group_owner_only, :except => [:index, :show]

  def new
    @group = Group.find(params[:group_id])
    @gathering = @group.gatherings.build
  end

  def create
    @group = Group.find(params[:group_id])
    @gathering = @group.gatherings.build(gathering_params)
    @gathering.creator_id = current_user.id
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

  private

  def gathering_params
    params.require(:gathering).permit(:name, :description, :date)
  end

  def group_owner_only
    group = Group.find(params[:group_id])
    redirect_to group_path(group) unless current_user && current_user.id == group.owner_id
  end
end
