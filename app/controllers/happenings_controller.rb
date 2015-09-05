class HappeningsController < ApplicationController
  def index
    @happenings = (Event.upcoming + Gathering.upcoming).sort do |a, b|
      a.date <=> b.date
    end
  end
end
