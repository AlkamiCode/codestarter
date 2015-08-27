class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      if @user.role == "admin"
        redirect_to admin_dashboard_path
      else
        redirect_to :back
      end
    else
      flash.now[:error] = "Invalid username or password"
      render :back
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
