class HappeningsController < ApplicationController
  def index
    if signed_in? && current_user.address
      case params[:radius]

        when 50
           @addresses = Address.within_radius(80467, current_user.address.latitude,
                                         current_user.address.longitude).where(
                                           :addressable_type => ['Event', 'Gathering'])
        when 100
           @addresses = Address.within_radius(160934, current_user.address.latitude,
                                         current_user.address.longitude).where(
                                           :addressable_type => ['Event', 'Gathering'])
        else
          @addresses = Address.within_radius(40234, current_user.address.latitude,
                                         current_user.address.longitude).where(
                                           :addressable_type => ['Event', 'Gathering'])
      end
    else

      @location = request.location

      case params[:radius]
        when 50
          @addresses = Address.within_radius(80467, @location.latitude.to_f,
                                         @location.longitude.to_f).where(
                                           :addressable_type => ['Event', 'Gathering'])

        when 100
           @addresses = Address.within_radius(40234, @location.latitude.to_f,
                                         @location.longitude.to_f).where(
                                           :addressable_type => ['Event', 'Gathering'])
        else
           @addresses = Address.within_radius(40234, @location.latitude.to_f,
                                         @location.longitude.to_f).where(
                                           :addressable_type => ['Event', 'Gathering'])

      end
    end


    #@addresses.joins

    # Return corresponding Gathering and Event instances
    @happenings = @addresses.includes(:addressable).map(&:addressable)

    @happenings = @happenings.sort do |a, b|
      a.date <=> b.date
    end
  end



 # http://stackoverflow.com/questions/16042044/rails-3-2-undefined-method-where-for-array-query-of-model-where
  # SELECT addresses.* FROM addresses
  # https://www.ruby-forum.com/topic/188459
end
