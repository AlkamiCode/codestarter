class Companies::ProjectsController < Companies::CompaniesController
  def index
    company = Company.find_by(url: params[:company])
    @projects = company.projects
  end
end
