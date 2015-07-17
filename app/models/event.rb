class Event < ActiveRecord::Base
  belongs_to :creator, :class_name => 'User'

  has_many :attendances, :foreign_key => :attended_event_id
  has_many :attendees, :through => :attendances

  validates :title, :description, :date, presence: true
end
