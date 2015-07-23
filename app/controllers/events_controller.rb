class EventsController < ApplicationController
  before_action :user_only, :except => [:show, :index]

  def new
    @group = Group.find(params[:group_id])
    @event = @group.events.build
  end

  def create
    @group = Group.find(params[:group_id])
    @event = @group.events.create(event_params)
    @event.creator_id = current_user.id
    if @event.save
      redirect_to @group
    else
      render :new
    end
  end

  def show
    group = Group.find(params[:group_id])
    @event = group.events.find(params[:id])
  end

  def index
  end

  private

  def event_params
    params.require(:event).permit(:title,
                                  :description,
                                  :date,
                                  :creator_id,
                                  :group_id)
  end

  def user_only
    redirect_to new_user_path unless signed_in?
  end
end
