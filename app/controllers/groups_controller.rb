class GroupsController < ApplicationController
  before_action :user_only, :except => [:show, :index]
  before_action :owner_only, :only => [:edit, :update]
  helper_method :new_gathering_permission?

  def show
    @group = Group.find(params[:id])
    members_only(@group) if @group.is_private
    @gatherings = @group.gatherings
    @membership = Membership.new
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
                                  :is_private,
                                  :restriction_type)
  end

  def user_only
    redirect_to new_user_path unless signed_in?
  end

  def owner_only
    @group = Group.find(params[:id])
    redirect_to root_path unless @group.owner == current_user
  end

  def members_only(group)
    redirect_to new_group_join_request_path(@group) unless group.members.include?(current_user)
  end

  def new_gathering_permission?
    if @group.restriction_type == 0
      true if @group.members.include?(current_user)

    elsif @group.restriction_type == 1
      true if @group.owner_id == current_user.id ||
              @group.moderators.include?(current_user)

    else
      true if current_user.id == @group.owner_id
    end
  end
end
