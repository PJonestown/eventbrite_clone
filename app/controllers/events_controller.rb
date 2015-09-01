class EventsController < ApplicationController
  before_action :set_event, :except => [:index, :new, :create]
  before_action :user_only, :except => [:show, :index]
  before_action :event_creator_only, :only => [:edit, :update, :destroy]

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      redirect_to @event
      flash[:success] = "Successfully created #{@event.title}"
    else
      render :new
    end
  end

  def show
  end

  def index
  end

  def edit

  end

  def update

  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title,
                                  :description,
                                  :date)
  end

  def user_only
    redirect_to new_user_path unless signed_in?
  end
end
