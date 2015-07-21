class GroupsController < ApplicationController
  def new
  end

  def create
  end

  def index
    @groups = Group.all
  end
end
