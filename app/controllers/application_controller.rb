class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authorize!

  helper_method :cart
  helper_method :current_user
  helper_method :all_categories

  add_flash_types :success, :info, :warning, :danger

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    session[:user_id].present?
  end

  def current_permission
    @current_permission ||= PermissionService.new(current_user)
  end

  def authorize!
    unless current_permission.allow?(params[:controller], params[:action])
      redirect_to root_url, danger: "You are not authorized to access this page."
    end
  end

  def cart
    @cart ||= Cart.new(session[:cart])
  end

  def all_categories
    Category.all
  end

  def render_not_found
    render "/public/404", status: 404
  end

  private

  def authorized?
    current_permission.allow?(params[:controller], params[:action])
  end

  def find_company
    @company = Company.where(url: params[:company]).first!
  end
end
