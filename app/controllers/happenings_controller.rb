class HappeningsController < ApplicationController
  def index
    # Placeholder. Need it sorted by date of event not creation
    @happenings = (Event.all + Gathering.all).sort { |a, b| a.created_at <=> b.created_at }
  end
end
