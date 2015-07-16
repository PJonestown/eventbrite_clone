class Event < ActiveRecord::Base
  belongs_to :creator, :class_name => 'User'
  has_many :attendees, :through => :event_attendees

  validates :title, :description, :date, presence: true
end
