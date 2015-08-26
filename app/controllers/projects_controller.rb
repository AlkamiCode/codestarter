class ProjectsController < ApplicationController
  def index
    @projects = Project.paginate(page: params[:page], per_page: 15)
  end

  def show
    @project = Project.find(params[:id])
  end
end
