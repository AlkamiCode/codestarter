class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    # @item = Item.find(params[:id])
  end
end
