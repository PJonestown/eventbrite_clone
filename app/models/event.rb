class Event < ActiveRecord::Base
  belongs_to :creator, :class_name => 'User'

  has_many :attendances, :foreign_key => :attended_event_id
  has_many :attendees, :through => :attendances

  has_one :address, :as => :addressable

  validates :name, :description, :date, presence: true

  scope :upcoming, -> { where("date >= ?", Time.zone.today) }
  scope :past, -> { where("date < ?", Time.zone.today) }
end
