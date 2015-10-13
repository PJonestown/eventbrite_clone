class HappeningsController < ApplicationController
  def index
    if params[:city] &&  false
      if params[:radius]

        @addresses = Address.near(params[:city], params[:radius]).where(
                                               :addressable_type => ['Event', 'Gathering'])
      else

        @addresses = Address.near(params[:city], 25).where(
                                               :addressable_type => ['Event', 'Gathering'])
      end
    else
      params[:radius] ||= 40234

      if signed_in? && current_user.address
          @addresses = Address.within_radius(params[:radius], current_user.address.latitude,
                                         current_user.address.longitude).where(
                                           :addressable_type => ['Event', 'Gathering'])
      else
        @location = request.location
        if @location


          @addresses = Address.within_radius(params[:radius], @location.latitude.to_f,
                                              @location.longitude.to_f).where(
                                               :addressable_type => ['Event', 'Gathering'])

        else
          @addresses = Address.all.where(:addressable_type => ['Event', 'Gathering'])
        end
      end
    end

    # Return corresponding Gathering and Event instances
    happenings = @addresses.includes(:addressable).map(&:addressable)

    upcoming_happenings = []
    happenings.each do |happening|
      if happening.class == Gathering && happening.approved? || happening.class == Event
        upcoming_happenings << happening if happening.date >= Time.zone.now
      end
    end

    @happenings = upcoming_happenings.sort_by &:date
  end
end
