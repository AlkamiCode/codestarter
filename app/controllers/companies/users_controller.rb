class Companies::UsersController < Companies::CompaniesController
  def index
    @collaborators = current_company.collaborators
  end

  def new
  end

  def create
    @user = User.find_by(username: "#{params[:user]}")
    if @user.company_id == current_company.id
      flash[:danger] =
        "#{@user.username.capitalize} is already a registered collaborator."
    else
      @user.roles << Role.where(name: "collaborator").first_or_initialize
      @user.update_attribute("company_id", current_company.id)
    end
    render :new
  end

  def update
    binding.pry
    # user = User.find_by(id: params[:id])
    # user.update_attribute("company_id", nil)
    # role = user.roles.where(name: "collaborator")
    # user.roles.delete(role)
    redirect_to :back
  end

  def search
    @user = User.find_by(username: params[:searchfield])
    render :new
  end
end
