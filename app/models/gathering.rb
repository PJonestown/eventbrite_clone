class Gathering < ActiveRecord::Base
  belongs_to :creator, :class_name => 'User'
  belongs_to :group

  has_many :gathering_attendances, :foreign_key => :attended_gathering_id
  has_many :attendees, :through => :gathering_attendances

  has_one :address, :as => :addressable

  validates :creator_id, :name, :description, :date, :presence => true
  validates :approved, inclusion: [true, false]

  scope :approved, -> { where(approved: true) }
  scope :unapproved, -> { where(approved: false) }
  scope :upcoming, -> { where("date >= ?", Time.zone.today) }
end
