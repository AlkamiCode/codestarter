class Companies::UsersController < Companies::CompaniesController
  def index
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
      send_collaborator_email(@user, "collaborator")
      @user.update_attribute("company_id", current_company.id)
    end
    render :new
  end

  def remove_collaborator
    user = User.find(params[:id])
    user.change_role(from: "collaborator", to: "former_collaborator")
    flash[:success] = "#{user.username} is no longer a collaborator"
    redirect_to :back
  end

  def reinstate
    user = User.find(params[:id])
    user.change_role(from: "former_collaborator", to: "collaborator")
    flash[:success] = "#{user.username} is now a collaborator"
    redirect_to :back
  end

  def search
    @user = User.find_by(username: params[:searchfield])
    unless @user
      flash[:danger] = "Could not find the specified user"
    end
    render :new
  end

  private

  def send_collaborator_email(user, type)
    NotificationMailer.contact(user.email, type).deliver_now
  end
end
