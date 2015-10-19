class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include GroupsHelper

  def set_coordinates
    if signed_in? && current_user.address
      @lat = current_user.address.latitude
      @long = current_user.address.longitude
    else
      @location = request.location
      if @location
        @lat = @location.latitude
        @long = @location.longitude
      end
    end
  end
end
