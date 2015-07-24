class User < ActiveRecord::Base
  has_many :created_events, :foreign_key => 'creator_id',
                            :class_name => 'Event'
  has_many :created_gatherings, :foreign_key => 'creator_id',
                                :class_name => 'Gathering'
  has_many :owned_groups, :foreign_key => 'owner_id',
                          :class_name => 'Group'

  has_many :attendances, :foreign_key => 'attendee_id'
  has_many :attended_events, :through => :attendances

  has_many :memberships, :foreign_key => 'member_id'
  has_many :group_memberships, :through => :memberships

  validates :username, uniqueness: true, presence: true
end
