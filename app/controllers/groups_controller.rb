class GroupsController < ApplicationController
  before_action :user_only, :except => [:show, :index]

  def show
    @group = Group.find(params[:id])
    @events = @group.events
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.owned_groups.build(group_params)
    if @group.save
      redirect_to @group
    else
      render :new
    end
  end

  def index
    @groups = Group.all
  end

  private

  def group_params
    params.require(:group).permit(:name, :owner_id, :description)
  end

  def user_only
    redirect_to new_user_path unless signed_in?
  end
end
