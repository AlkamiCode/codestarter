class Companies::ProjectsController < Companies::CompaniesController
  before_action :find_company
  before_action :find_project, only: [:show, :update, :destroy]

  def index
    @sorted_projects = current_company.sorted_projects
    @active_projects = current_company.projects.where(status: 0).count
    render :index
  end

  def show
    @related_projects = Project.all.sample(4)
  end

  def new
    if current_company == current_user.company
      @project = Project.new
      @categories = all_categories.map { |c| [ c.name, c.id ] }
    else
      flash[:danger] = "You are not authorized to view this page."
      redirect_to root_path
    end
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to company_project_path(company: current_company.url, id: @project.id)
    else
      flash[:danger] = "There was a problem creating your project."
      render :new
    end
  end

  def edit
    if current_company == current_user.company
      @project = @company.projects.find(params[:id])
    else
      flash[:danger] = "You are not authorized to view this page."
      redirect_to root_path
    end
  end

  def update
    @project.update(project_params)
    flash[:success] = "#{@project.name} successfully updated!"
    redirect_to company_project_path(company: current_company.url, id: @project.id)
  end

  def destroy
    if current_company == current_user.company
      @project.delete
      flash[:success] = "#{@project.name} successfully removed."
      redirect_to company_projects_path(company: current_company.url)
    else
      flash[:danger] = "You are not authorized to view this page."
      redirect_to root_path
    end
  end

  private

  def find_project
    @project = @company.projects.find(params[:id])
  end

  def project_params
    prms = params.require(:project).permit(:name,
                                           :description,
                                           :funding_goal,
                                           :image,
                                           :category_id)
    prms[:company_id], prms[:current_funding], prms[:end_date] =
      current_company.id, 0, formatted_date
    prms
  end

  def formatted_date
    values = params[:end_date].values.map(&:to_i)
    DateTime.new(values[0], values[1], values[2])
  end
end
