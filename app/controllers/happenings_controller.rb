class HappeningsController < ApplicationController
  def index
    @happenings = (Event.upcoming + Gathering.upcoming).sort { 
      |a, b| a.date <=> b.date }
  end
end
