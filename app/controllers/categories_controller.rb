class CategoriesController < ApplicationController
  before_action :find_company
  before_action :find_category

  def show
  end

  private

  def find_category
    @category = Category.find_by(slug: params[:id])
  end

  def find_company
    @company = Company.where(url: params[:company]).first!
  end
end
