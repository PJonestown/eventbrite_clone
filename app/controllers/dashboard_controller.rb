class DashboardController < ApplicationController
  def show
    # Placeholder. Need it sorted by date of event not creation
    @combined = (Event.all + Gathering.all).sort{ |a,b| a.created_at <=> b.created_at }
  end
end
