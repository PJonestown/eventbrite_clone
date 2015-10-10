class HappeningsController < ApplicationController
  def index
    if params[:city]
      case params[:radius]

      when 50
        @addresses = Address.near(params[:city], 50).where(
                                               :addressable_type => ['Event', 'Gathering'])

      when 100
        @addresses = Address.near(params[:city], 100).where(
                                               :addressable_type => ['Event', 'Gathering'])

      else
        @addresses = Address.near(params[:city], 25).where(
                                               :addressable_type => ['Event', 'Gathering'])
      end
    else


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
        if @location

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
        else
          @addresses = Address.all
        end
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
