class EventsController < ApplicationController
  before_action :user_only, :except => [:show, :index]

  def new
    @event = Event.new
  end

  def create
    @event = @current_user.created_events.build(event_params)
    if @event.save
      redirect_to @event
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def index
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :date, :creator_id)
  end

  def user_only
    redirect_to new_user_path unless signed_in?
  end
end
