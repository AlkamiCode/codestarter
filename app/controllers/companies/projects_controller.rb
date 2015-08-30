class Companies::ProjectsController < Companies::CompaniesController
  before_action :find_company

  def index
    @projects = current_company.projects
    render :index
  end

  def show
    @project = @company.projects.find(params[:id])
    @related_projects = Project.all.sample(4)
  end

  def new
    @project = Project.new(params[:company])
  end

  def create
    @project = Project.new(project_params)
    if save
      redirect_to company_project_path(company: current_company.url, id: @project.id)
    else
      flash[:danger] = "There was a problem creating your project."
      render :new
    end
  end

  def destroy
    @project = @company.projects.find(params[:id])
    @project.delete
    redirect_to company_projects_path(company: current_company.url)
  end

  private

  def find_company
    @company = Company.where(url: params[:company]).first!
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
