class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @groups = @category.groups
  end
end
