class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include GroupsHelper

  def set_coordinates
      if signed_in? && current_user.address
        @latitude = current_user.address.latitude
        @longitude = current_user.address.longitude
      else
        location = request.location
        if location
          @latitude = location.latitude
          @longitude = location.longitude
        end
      end
  end
end
