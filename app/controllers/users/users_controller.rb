class Users::UsersController < ApplicationController
  before_action :user_not_found
  helper_method :current_user

  def user_not_found
    # render file: "/public/404" unless current_user
    redirect_to root_path if current_user.nil?
  end

  def current_user
    @current_user ||= User.find_by(url: params[:user])
  end
end
