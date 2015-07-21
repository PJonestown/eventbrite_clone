class User < ActiveRecord::Base
  has_many :created_events, :foreign_key => 'creator_id',
                            :class_name => 'Event'
  has_many :owned_groups, :foreign_key => 'owner_id',
                          :class_name => 'Group'

  has_many :attendances, :foreign_key => 'attendee_id'
  has_many :attended_events, :through => :attendances

  validates :username, uniqueness: true, presence: true
end
