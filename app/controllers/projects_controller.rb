class ProjectsController < ApplicationController
  def index
    @projects = Project.where(status: 0).paginate(page: params[:page], per_page: 15)
  end

  def show
    @project          = Project.find(params[:id])
    @related_projects = Project.all.sample(4)
  end
end
