class PermissionService
  attr_reader :user, :controller, :action

  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller, action)
    @controller = controller
    @action     = action

    if user.registered_user?
      registered_user_permissions
    elsif user.company_admin?
      company_admin_permissions
    else
      guest_user_permissions
    end
  end

  private

  def guest_user_permissions
    return true if controller == "homepage" && action == "index"
    return true if controller == "companies" && action.in?(%w(index show))
    return true if controller == "sessions" && action.in?(%w(new create))
  end

  def registered_user_permissions
    return true if controller == "homepage" && action == "index"
    return true if controller == "companies" && action.in?(%w(index show))
    return true if controller == "sessions" && action.in?(%w(new create destroy))
  end

  def company_admin_permissions
    return true if controller == "homepage" && action == "index"
    return true if controller == "companies" && action.in?(%w(index show))
    return true if controller == "sessions" && action.in?(%w(new create destroy))
    return true if controller == "projects" && action.in?(%w(index show))
    return true if controller == "orders" && action.in?(%w(index show))
  end
end
