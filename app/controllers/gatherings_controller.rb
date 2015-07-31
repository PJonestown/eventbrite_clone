class GatheringsController < ApplicationController
  before_action :check_permission, :only => [:new, :create]

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

  def check_permission
    @group = Group.find(params[:group_id])
    redirect_to :back unless  new_gathering_permission?
  end
end
