class GroupsController < ApplicationController
  before_action :set_group, :except => [:new, :create, :index]
  before_action :user_only, :except => [:show, :index]
  before_action :owner_only, :only => [:edit, :update]

  def show
    members_only(@group) if @group.is_private
    @gatherings = @group.gatherings.approved
    @membership = Membership.new
  end

  def new
    @group = Group.new
    @categories = Category.all
  end

  def create
    @group = current_user.owned_groups.build(group_params)
    if @group.save
      Membership.create(member_id: current_user.id, group_membership_id: @group.id)
      redirect_to @group
      flash[:success] = "Successfully created #{@group.name}"
    else
      render :new
    end
  end

  def index
    @groups = Group.all.includes(:owner)
  end

  def edit
    @categories = Category.all
  end

  def update
    @group.update!(group_params)
    redirect_to @group
    flash[:success] = "Successfully updated #{@group.name}"
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name,
                                  :owner_id,
                                  :description,
                                  :category_id,
                                  :is_private,
                                  :restricted)
  end

  def user_only
    redirect_to new_user_path unless signed_in?
  end

  def owner_only
    set_group
    redirect_to root_path unless @group.owner == current_user
  end

  def members_only(group)
    redirect_to new_group_join_request_path(@group) unless signed_in? && group.members.include?(current_user)
  end
end
