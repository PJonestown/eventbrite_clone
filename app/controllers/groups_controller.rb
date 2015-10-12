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
      redirect_to new_group_address_path(@group)
      flash[:success] = "Successfully created #{@group.name}"
    else
      render :new
    end
  end

  def index

    # TODO: This breaks a test in groups_search... why?
    #
  #  if params[:city] && params[:city] != 
   #   if params[:radius]
#
 #       @addresses = Address.near(params[:city], params[:radius]).where(
  #                                             :addressable_type => ['Event', 'Gathering'])
   #   else
#
 #       @addresses = Address.near(params[:city], 25).where(
  #                                             :addressable_type => ['Event', 'Gathering'])
   #   end
   # else

      if signed_in? && current_user.address
        if params[:radius]

          @addresses = Address.within_radius(params[:radius], current_user.address.latitude,
                                          current_user.address.longitude).where(
                                            :addressable_type => ['Group'])
          else
            @addresses = Address.within_radius(40234, current_user.address.latitude,
                                          current_user.address.longitude).where(
                                            :addressable_type => ['Group'])
        end
      else

        @location = request.location

        if params[:radius]
          @addresses = Address.within_radius(params[:radius], @location.latitude,
                                          @location.longitude).where(
                                            :addressable_type => ['Group'])

          else
            @addresses = Address.within_radius(40234, @location.latitude,
                                          @location.longitude).where(
                                            :addressable_type => ['Group'])
        end
      end
    #end

    if params[:category]

      categorized_groups = []
      @addresses.map(&:addressable).each do |group|
        categorized_groups << group if group.category_id == params[:category].to_i
      end

      @groups = categorized_groups

    else
      @groups = @addresses.map(&:addressable)
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
