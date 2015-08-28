class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  helper_method :cart
  helper_method :current_user
  helper_method :current_admin?

  def cart
    @cart ||= Cart.new(session[:cart])
  end

  def current_user
    @current_user ||= User.find_by(url: params[:user]) if params[:user]
  end

  def current_admin?
    current_user && current_user.admin?
  end


  def render_not_found
    render "/public/404", status: 404
  end
end
