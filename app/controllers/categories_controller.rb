class CategoriesController < ApplicationController
  before_action :find_category

  def show
    @sorted_projects = @category.projects
  end

  private

  def find_category
    @category = Category.find_by(slug: params[:id])
  end
end
