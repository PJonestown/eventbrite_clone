class Address < ActiveRecord::Base
  belongs_to :addressable, :polymorphic => true

  validates :location, :latitude, :longitude, :presence => true

  #geocoded_by :location
  #before_validation :geocode,
  #  :if => ->(obj) { obj.location_changed? }

  #acts_as_geolocated

  def self.psql_radius_search(radius, lat, long)
    within_radius(radius, lat, long)
  end

  def self.geocode_radius_search(city, radius)
    near(city, radius)
  end

  def self.happenings
    where(:addressable_type => %w(Event Gathering))
  end

  def self.groups
    where(:addressable_type => ['Group'])
  end
end
