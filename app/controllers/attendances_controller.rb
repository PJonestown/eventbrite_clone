class AttendancesController < ApplicationController
  def create
    @event = Event.find(params[:attendance][:attended_event_id])
    current_user.attendances.create(attended_event_id: @event.id)
    redirect_to @event
  end

  def destroy
    @attendance = Attendance.find(params[:id])
    current_user.attendances.destroy(@attendance)
    redirect_to(:back)
  end

  private

  def attendance_params
    params.require(:attendance).permit(:attendee_id, :attended_event_id)
  end
end
