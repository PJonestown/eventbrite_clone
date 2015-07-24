class GatheringAttendancesController < ApplicationController
  def create
    @gathering = Gathering.find(params[:gathering_attendance][:attended_gathering_id])
    current_user.gathering_attendances.create(attended_gathering_id: @gathering.id)
    redirect_to(:back)
  end

  def destroy
    @attendance = GatheringAttendance.find(params[:id])
    current_user.gathering_attendances.destroy(@attendance)
    redirect_to(:back)
  end

  private

  def gathering_attendance_params
    params.require(:attendance).permit(:attendee_id, :attended_gathering_id)
  end
end
