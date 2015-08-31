class Companies::UsersController < Companies::CompaniesController
  def index
    @collaborators = current_company.collaborators
  end

  def new
  end

  def create
    @user = User.find_by(username: "#{params[:user]}")

    if @user.company_id == current_company.id
      flash[:danger] = "#{@user.username.capitalize} already is a registered collaborator."
    else
      @user.roles << Role.where(name: "company_admin").first_or_initialize
      @user.update_attribute('company_id', current_company.id)
    end
    render :new
  end

  def search
    @user = User.find_by(username: params[:searchfield])
    render :new
  end
end
