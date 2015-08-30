class Companies::ProjectsController < Companies::CompaniesController
  before_action :find_company, only: [:index, :show]

  def index
    @projects = current_company.projects.sort_by do |project|
      project.funding_in_percentage
    end
    @active_projects = Company.count_active_projects(@projects)
    render :index
  end

  def show
    @project = @company.projects.find(params[:id])
  end

  def new
    current_company_admin?
    @project = Project.new
  end

  def create
    @project = Project.create(project_params)
    redirect_to company_project_path(company: current_company.url, id: @project.id)
  end

  private

  def find_company
    @company = Company.find_by(url: params[:company])
  end

  def current_company_admin?
    unless current_user.company == current_company
      redirect_to root_url, danger: "You are not authorized to access this page."
    end
  end

  def project_params
    prms = params.require(:project).permit(:name,
                                           :description,
                                           :funding_goal,
                                           :image)
    prms[:company_id], prms[:current_funding], prms[:end_date] =
      current_company.id, 0, formatted_date
    prms
  end

  def formatted_date
    values = params[:end_date].values.map(&:to_i)
    DateTime.new(values[0], values[1], values[2])
  end
end
