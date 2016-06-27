class HappeningsController < ApplicationController
  def index
    params[:radius] ||= 40234

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

    search = params[:search]
    if search
      searched_happenings = upcoming_happenings.select{ |h| h.name.downcase.include? search.downcase}
    else
      searched_happenings = upcoming_happenings
    end

    @happenings = searched_happenings.sort_by &:date
  end
end
