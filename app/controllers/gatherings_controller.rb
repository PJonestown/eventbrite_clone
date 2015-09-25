class GatheringsController < ApplicationController
  include GatheringsHelper

  before_action :set_group, :only => [:index, :create, :new]
  before_action :set_gathering, :except => [:new, :create]
  before_action :members_only, :only => [:new, :create]
  before_action :correct_users_only, :only => [:update]
  before_action :correct_users_if_unapproved, :only => [:show]
  before_action :creator_only, :only => [:edit, :destroy]

  def new
    @gathering = @group.gatherings.build
  end

  def create
    @gathering = @group.gatherings.build(gathering_params)
    @gathering.creator_id = current_user.id
    @gathering.approved = false if @group.restricted && !privileged_member?
    if @gathering.save
      redirect_to new_gathering_address_path(@gathering)
      flash[:success] = "#{@gathering.name} created for #{@group.name}"
    else
      render :new
    end
  end

  def show
    @group = @gathering.group
  end

  def edit
  end

  # TODO: Too many lines. Need to DRY
  def update
    if @gathering.creator_id == current_user.id
      if @gathering.update(gathering_params)
        redirect_to @gathering
        flash[:success] = "Updated #{@gathering.name}"
      else
        redirect_to edit_gathering_path(@gathering)
      end
    elsif privileged_member?
      if @gathering.update(mod_restricted_gathering_params)
        redirect_to @gathering
        flash[:success] = "Approved #{@gathering.name} for #{@group.name}"
      else
        redirect_to root_path
      end
    end
  end

  def destroy
    @group = @gathering.group
    @gathering.destroy
    flash[:success] = "Gathering deleted"
    redirect_to @group
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
    redirect_to group_path(@group) unless privileged_member? ||
                                          gathering_creator?
  end

  def correct_users_if_unapproved
    return if @gathering.approved
    correct_users_only
  end

  def creator_only
    unless gathering_creator?
      redirect_to root_path
      flash[:warning] = "You don't have permission for this action"
    end
  end
end
