class User < ActiveRecord::Base
  has_many :created_events, :foreign_key => 'creator_id',
                            :class_name => 'Event'
  has_many :attendances
  has_many :attended_events, :through => :attendances,
                             :foreign_key => 'attendee_id'

  validates :username, uniqueness: true, presence: true
end
