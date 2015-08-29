class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      # if @user.role == "admin"
      #   redirect_to admin_dashboard_path
      # else
        flash[:success] = "Welcome back, #{@user.username}!"
        redirect_to :back
      # end
    else
      flash[:danger] = "Invalid username or password"
      redirect_to :back
    end
  end

  def destroy
    session.clear
    flash[:success] = "You have succesfully logged out."
    redirect_to root_path
  end
end
