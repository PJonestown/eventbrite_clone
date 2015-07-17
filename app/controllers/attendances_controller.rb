class AttendancesController < ApplicationController
  def create
    @event = Event.find(params[:attendance][:attended_event_id])
    current_user.attendances.create(attended_event_id: @event_id)
    redirect_to @event
  end
end
