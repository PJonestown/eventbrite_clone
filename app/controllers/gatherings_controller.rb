class GatheringsController < ApplicationController
  before_action :group_owner_only, :except => [:index]

  def new
    group = Group.find(params[:group_id])
    @gathering = group.gatherings.build
  end

  def index
  end

  private

  def group_owner_only
    group = Group.find(params[:group_id])
    redirect_to group_path(group) unless current_user && current_user.id == group.owner_id
  end
end
