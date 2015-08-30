class PermissionService
  attr_reader :user, :controller, :action

  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller, action)
    @controller = controller
    @action     = action
    if user.company_admin?
      company_admin_permissions
    elsif user.registered_user?
      registered_user_permissions
    else
      guest_user_permissions
    end
  end

  private

  def guest_user_permissions
    return true if controller == "homepage" && action == "index"
    return true if controller == "projects" && action.in?(%w(index show))
    return true if controller == "companies" && action.in?(%w(index show))
    return true if controller == "companies/projects" && action.in?(%w(index show))
    return true if controller == "sessions" && action.in?(%w(new create))
    return true if controller == "users" && action.in?(%w(create))
    return true if controller == "cart_items" && action.in?(%w(index create update destroy))
  end

  def registered_user_permissions
    return true if controller == "homepage" && action == "index"
    return true if controller == "projects" && action.in?(%w(index show))
    return true if controller == "companies" && action.in?(%w(index show))
    return true if controller == "companies/projects" && action.in?(%w(index show))
    return true if controller == "sessions" && action.in?(%w(new create destroy))
    return true if controller == "users" && action.in?(%w(show update))
    return true if controller == "cart_items" && action.in?(%w(index create update destroy))
    return true if controller == "orders" && action.in?(%w(index show create))
  end

  def company_admin_permissions
    return true if controller == "homepage" && action == "index"
    return true if controller == "companies" && action.in?(%w(index show))
    return true if controller == "companies/projects" && action.in?(%w(index show new create edit update destroy))
    return true if controller == "sessions" && action.in?(%w(new create destroy))
    return true if controller == "users" && action.in?(%w(show update))
    return true if controller == "cart_items" && action.in?(%w(index create update destroy))
    return true if controller == "projects" && action.in?(%w(index show))
    return true if controller == "orders" && action.in?(%w(index show create))
  end
end
