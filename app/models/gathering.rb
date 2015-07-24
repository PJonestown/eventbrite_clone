class Gathering < ActiveRecord::Base
  belongs_to :creator, :class_name => 'User'
  belongs_to :group

  has_many :gathering_attendances, :foreign_key => :attended_gathering_id
  has_many :attendees, :through => :gathering_attendances

  validates :creator_id, :name, :description, :date, :presence => true
end
