class EventsController < ApplicationController
  before_action :user_only, :except => [:show, :index]

  def new
    @event = Event.new
  end

  private

  def user_only
    redirect_to new_user_path unless signed_in?
  end
end
