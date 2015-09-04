class HappeningsController < ApplicationController
  def index
    # Placeholder. Need it sorted by date of event not creation
    @happenings = (Event.upcoming + Gathering.upcoming).sort { |a, b| a.date <=> b.date }
  end
end
