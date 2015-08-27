class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def cart
    @cart ||= Cart.new(session[:cart])
  end

  helper_method :cart

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def current_admin?
    current_user && current_user.admin?
  end

  helper_method :current_admin?

  def render_not_found
    render "/public/404", status: 404
  end
end
