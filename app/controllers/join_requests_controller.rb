class JoinRequestsController < ApplicationController
  def new
    @group = Group.find(params[:group_id])
    @join_request = JoinRequest.new
  end

  def index
  end
end
