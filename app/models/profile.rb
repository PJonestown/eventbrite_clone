class Profile < ActiveRecord::Base
  belongs_to :user

  validates :location, :latitude, :longitude, :presence => true

  geocoded_by :location
  before_validation :geocode,
    :if => lambda{ |obj| obj.location_changed? }
end
