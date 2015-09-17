class Address < ActiveRecord::Base
  belongs_to :addressable, :polymorphic => true

  validates :location, :latitude, :longitude, :presence => true

  geocoded_by :location
  before_validation :geocode,
    :if => ->(obj) { obj.location_changed? }
end
