class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @groups = @category.groups
  end

  def index
    @categories = Category.all
  end
end
