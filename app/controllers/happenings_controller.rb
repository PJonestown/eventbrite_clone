class HappeningsController < ApplicationController
  def index
    if signed_in? && current_user.address
      #@addresses = Address.where(:addressable_type => ["Gathering", "Event"])
     # @addresses = @addresses.witihin_radius(50, current_user.address.latitude,
      #                     current_user.address.longitude)
    #end

    #gatherings = @addresses.where(addressable_type: 'Gathering')
    #events = @addresses.where(addressable_type: 'Event'
      @addresses = Address.within_radius(50, current_user.address.latitude,
                                            current_user.address.longitude)
      @addresses = @addresses.where(:addressable_type => ['Event', 'Gathering'])
    end


    #@happenings = (gather + events).sort do |a, b|
     # a.date <=> b.date
    #end
    @happenings = @addresses.includes(:addressable).map(&:addressable)
    #@happenings = @happenings.where("date >= ?", Time.zone.today)
    @happenings = @happenings.sort do |a, b|
      a.date <=> b.date
    end
  end
end
