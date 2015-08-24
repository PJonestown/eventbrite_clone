class GatheringsController < ApplicationController
  before_action :set_group
  before_action :set_gathering, :except => [:new, :create]
  before_action :members_only, :only => [:new, :create]
  before_action :correct_users_only, :only => [:update]
  before_action :correct_users_if_unapproved, :only => [:show]

  def new
    @gathering = @group.gatherings.build
  end

  def create
    @gathering = @group.gatherings.build(gathering_params)
    @gathering.creator_id = current_user.id
    @gathering.approved = false if @group.restricted && !privileged_member?
    if @gathering.save
      redirect_to group_gathering_path(@group, @gathering)
      flash[:success] = "#{@gathering.name} created for #{@group.name}"
    else
      render :new
    end
  end

  def show
  end

  # TODO: Too many lines. Need to DRY
  def update
    if privileged_member?
      if @gathering.update(mod_restricted_gathering_params)
        redirect_to group_gathering_path(@group, @gathering)
        flash[:success] = "Approved #{@gathering.name} for #{@group.name}"
      else
        redirect_to root_path
      end
    else
      if @gathering.update(gathering_params)
        redirect_to group_gathering_path(@group, @gathering)
        flash[:success] = "Successfully updated #{@gathering.name}"
      else
        redirect_to root_path
      end
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_gathering
    @gathering = Gathering.find(params[:id])
  end

  def gathering_params
    params.require(:gathering).permit(:name, :description, :date)
  end

  def mod_restricted_gathering_params
    params.require(:gathering).permit(:approved)
  end

  def members_only
    set_group
    redirect_to :back unless signed_in? && @group.members.include?(current_user)
  end

  def correct_users_only
    set_group
    set_gathering
    redirect_to group_path(@group) unless signed_in?
    redirect_to group_path(@group) unless current_user.id == @gathering.creator_id ||
                                          privileged_member?
  end

  def correct_users_if_unapproved
    set_gathering
    return if @gathering.approved
    correct_users_only
  end
end
