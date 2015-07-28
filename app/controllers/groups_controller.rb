class GroupsController < ApplicationController
  before_action :user_only, :except => [:show, :index]
  before_action :owner_only, :only => [:edit, :update]

  def show
    @group = Group.find(params[:id])
    members_only(@group) if @group.is_private
    @gatherings = @group.gatherings
  end

  def new
    @group = Group.new
    @categories = Category.all
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
    @groups = Group.all.includes(:owner)
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    group = Group.find(params[:id])
    group.update!(group_params)
    redirect_to group
  end

  private

  def group_params
    params.require(:group).permit(:name,
                                  :owner_id,
                                  :description,
                                  :category_id,
                                  :is_private)
  end

  def user_only
    redirect_to new_user_path unless signed_in?
  end

  def owner_only 
    @group = Group.find(params[:id])
    redirect_to root_path unless @group.owner == current_user
  end

  def members_only(group)
    redirect_to new_group_join_request_path unless group.members.include?(current_user) 
  end
end
