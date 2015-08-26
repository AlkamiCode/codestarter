class Companies::ProjectsController < Companies::CompaniesController
  before_action :find_company, only: [:index, :show]

  def index
    @projects = current_company.projects
    render :index
  end

  def show
    @project = company.projects.find[params[:id]]
  end

  private

  def find_company
    @company = Company.find_by(url: params[:company])
  end
end
