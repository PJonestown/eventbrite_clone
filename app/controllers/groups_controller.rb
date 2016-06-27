class GroupsController < ApplicationController
  before_action :set_group, :except => [:new, :create, :index]
  before_action :user_only, :except => [:show, :index]
  before_action :privileged_members_only, :only => [:edit, :update]
  before_action :owner_only, :only => [:destroy]

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
      Moderation.create(moderator_id: current_user.id, moderated_group_id: @group.id)
      redirect_to new_group_address_path(@group)
      flash[:success] = "Successfully created #{@group.name}"
    else
      render :new
    end
  end

  def index
    params[:radius] ||= 40234

    if signed_in? && current_user.address && current_user.address.location != params[:city] && params[:city] ||
       !signed_in? && params[:city]

      radius_in_miles = (params[:radius].to_i / 1609)

      addresses = Address.geocode_radius_search(params[:city], radius_in_miles).groups.includes(:addressable)

    else

      set_coordinates unless @lat

      if @lat
        addresses = Address.psql_radius_search(params[:radius], @lat, @long).groups.includes(:addressable)
      else
        addresses = Address.groups.includes(:addressable)
      end
    end

    if params[:category]

      categorized_groups = []
      addresses.map(&:addressable).each do |group|
        categorized_groups << group if group.category_id == params[:category].to_i
      end


    search = params[:search]
    if search
      searched_groups = categorized_groups.select{ |g| g.name.downcase.include? search.downcase}
    else
      searched_groups = categorized_groups
    end

      @groups = searched_groups

    else

    search = params[:search]
    if search
      searched_groups = addresses.map(&:addressable).select{ |g| g.name.downcase.include? search.downcase}
    else
      searched_groups = addresses.map(&:addressable)
    end
      @groups = searched_groups
    end

  end

  def edit
    @categories = Category.all
  end

  def update
    if @group.update(group_params)
      redirect_to @group
      flash[:success] = "Successfully updated #{@group.name}"
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to root_path
    flash[:success] = 'Successfully deleted Group'
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name,
                                  :description,
                                  :category_id,
                                  :is_private,
                                  :restricted)
  end

  def user_only
    redirect_to new_user_path unless signed_in?
  end

  def owner_only
    redirect_to root_path unless @group.owner == current_user
  end

  def privileged_members_only
    redirect_to :back unless privileged_member?
  end

  def members_only(group)
    redirect_to new_group_join_request_path(@group) unless signed_in? && group.members.include?(current_user)
  end
end
