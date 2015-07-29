class JoinRequestsController < ApplicationController
  before_action :users_only

  def new
    @group = Group.find(params[:group_id])
    @join_request = JoinRequest.new
  end

  def create
    @group = Group.find(params[:group_id])
    @join_request = @group.join_requests.build(join_request_params)
    @join_request.user_id = current_user.id
    if @join_request.save
      redirect_to root_path
    else
      render :new
    end
  end

  def index
  end

  private

  def join_request_params
    params.require(:join_request).permit(:user_id, :group_id, :message)
  end

  def users_only
    redirect_to sign_in_path unless signed_in?
  end
end
