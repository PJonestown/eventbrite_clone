class HappeningsController < ApplicationController
  def index
    params[:radius] ||= 40234

    # If signed in user searches for a city other than the one provided in
    # address OR if a guest searches for a city which isn't saved as a cookie
    if signed_in? && current_user.address && current_user.address.location != params[:city] && params[:city] ||
       !signed_in? && params[:city]

      radius_in_miles = (params[:radius].to_i / 1609)

      addresses = Address.geocode_radius_search(params[:city], radius_in_miles).happenings
    else

      set_coordinates unless @lat
      if @lat
        addresses = Address.psql_radius_search(params[:radius], @lat, @long).happenings
      else
        addresses = Address.happenings
      end
    end

    happenings = addresses.includes(:addressable).map(&:addressable)

    upcoming_happenings = []
    happenings.each do |happening|
      if happening.class == Gathering && happening.approved? || happening.class == Event
        upcoming_happenings << happening if happening.date >= Time.zone.now
      end
    end

    @happenings = upcoming_happenings.sort_by &:date
  end
end
