class HappeningsController < ApplicationController
  def index
    # If signed in user searches for a city other than the one provided in
    # address OR if a guest searches for a city which isn't saved as a cookie
    if signed_in? && current_user.address.location != params[:city] && params[:city] ||
        !signed_in? && params[:city]
      params[:radius] ||= 25

        @addresses = Address.near(params[:city], params[:radius]).where(
                                               :addressable_type => ['Event', 'Gathering'])
    else

      params[:radius] ||= 40234
      set_coordinates
      if @latitude

        @addresses = Address.within_radius(params[:radius], @latitude, @longitude).where(
                                               :addressable_type => ['Event', 'Gathering'])
      else
        @addresses = Address.all.where(:addressable_type => ['Event', 'Gathering'])

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
