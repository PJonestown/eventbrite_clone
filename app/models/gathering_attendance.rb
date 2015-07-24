class GatheringAttendance < ActiveRecord::Base
  belongs_to :attendee, :class_name => 'User'
  belongs_to :attended_gathering, :class_name => 'Gathering'

  validates :attended_gathering_id, :attendee_id, :presence => true
end
