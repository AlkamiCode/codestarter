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
    if params[:reinstate].nil?
      user = User.find_by(id: params[:id])
      role = user.roles.where(name: "collaborator")
      user.roles.delete(role)
      user.roles << Role.create(name: "former_collaborator")
      flash[:success] = "#{user.username} is no longer a collaborator"
      redirect_to :back
    end
  end

  def reinstate
    if params[:reinstate]
      user = User.find_by(id: params[:id])
      role = user.roles.where(name: "former_collaborator")
      user.roles.delete(role)
      user.roles << Role.create(name: "collaborator")
      flash[:success] = "#{user.username} is now a collaborator"
      redirect_to :back
    end
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
